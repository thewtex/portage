ETYPE="gcc-compiler"

inherit toolchain

GCC_VERSION="4.4.4"

EAPI="2"

DESCRIPTION="gcc-code-assist is a custom GCC that has functions such as code
completion"
HOMEPAGE="http://cx4a.org/software/gccsense/"
SRC_URI="http://cx4a.org/pub/gccsense/${P}-${GCC_VERSION}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=sys-devel/gcc-4.4"
RDEPEND=""

S="${WORKDIR}/${P}-${GCC_VERSION}"

src_unpack() {
	default_src_unpack
}

src_configure() {
	gcc_do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p "${WORKDIR}"/build
	pushd "${WORKDIR}"/build > /dev/null

	GCC_TARGET_NO_MULTILIB=1
	GCC_LANG="c,c++"
	einfo "Configuring ${PN} ..."
	gcc_do_configure --program-suffix=-code-assist --disable-bootstrap
}

src_compile() {
	touch "${S}"/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	[[ ! -x /usr/bin/perl ]] \
		&& find "${WORKDIR}"/build -name '*.[17]' | xargs touch

	einfo "Compiling ${PN} ..."
	gcc_do_make all

	# Do not create multiple specs files for PIE+SSP if boundschecking is in
	# USE, as we disable PIE+SSP when it is.
	if [[ ${ETYPE} == "gcc-compiler" ]] && want_split_specs && ! want_minispecs; then
		split_out_specs_files || die "failed to split out specs"
	fi

	popd > /dev/null
}

src_install() {
	# This is copied from the toolchain.eclass and edited when appropriate.
	cd "${WORKDIR}"/build

	# Do allow symlinks in private gcc include dir as this can break the build
	find gcc/include*/ -type l -print0 | xargs -0 rm -f
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in $(find gcc/include*/ -name '*.h') ; do
		grep -q 'It has been auto-edited by fixincludes from' "${x}" \
			&& rm -f "${x}"
	done
	# Do the 'make install' from the build directory
	S=${WORKDIR}/build \
	emake -j1 DESTDIR="${D}" install || die

	# Punt some tools which are really only useful while building gcc
	find "${D}" -name install-tools -prune -type d -exec rm -rf "{}" \;
	# This one comes with binutils
	find "${D}" -name libiberty.a -exec rm -f "{}" \;

	# Move the libraries to the proper location
	gcc_movelibs

	dodir /etc/env.d/gcc
	create_gcc_env_entry

	# Move <cxxabi.h> to compiler-specific directories
	[[ -f ${D}${STDCXX_INCDIR}/cxxabi.h ]] && \
		mv -f "${D}"${STDCXX_INCDIR}/cxxabi.h "${D}"${LIBPATH}/include/

	# These should be symlinks
	dodir /usr/bin
	cd "${D}"${BINPATH}
	for x in cpp gcc g++ c++ g77 gcj gcjh gfortran ; do
		# For some reason, g77 gets made instead of ${CTARGET}-g77...
		# this should take care of that
		[[ -f ${x} ]] && mv ${x} ${CTARGET}-${x}

		if [[ -f ${CTARGET}-${x} ]] && ! is_crosscompile ; then
			ln -sf ${CTARGET}-${x} ${x}

			# Create version-ed symlinks
			dosym ${BINPATH}/${CTARGET}-${x} \
				/usr/bin/${CTARGET}-${x}-${GCC_CONFIG_VER}
			dosym ${BINPATH}/${CTARGET}-${x} \
				/usr/bin/${x}-${GCC_CONFIG_VER}
		fi

		if [[ -f ${CTARGET}-${x}-${GCC_CONFIG_VER} ]] ; then
			rm -f ${CTARGET}-${x}-${GCC_CONFIG_VER}
			ln -sf ${CTARGET}-${x} ${CTARGET}-${x}-${GCC_CONFIG_VER}
		fi
	done
	exeinto /usr/bin
	doexe gcc-code-assist
	doexe g++-code-assist

	# Now do the fun stripping stuff
	env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${BINPATH}"
	env RESTRICT="" CHOST=${CTARGET} prepstrip "${D}${LIBPATH}"
	# gcc used to install helper binaries in lib/ but then moved to libexec/
	[[ -d ${D}${PREFIX}/libexec/gcc ]] && \
		env RESTRICT="" CHOST=${CHOST} prepstrip "${D}${PREFIX}/libexec/gcc/${CTARGET}/${GCC_CONFIG_VER}"

	cd "${S}"
	rm -rf "${D}"/usr/share/{man,info}
	rm -rf "${D}"${DATAPATH}/{man,info}

	# prune empty dirs left behind
	for x in 1 2 3 4 ; do
		find "${D}" -type d -exec rmdir "{}" \; >& /dev/null
	done

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
	if ! is_crosscompile ; then
		insinto "${DATAPATH}"
		if tc_version_is_at_least 4.0 ; then
			newins "${GCC_FILESDIR}"/awk/fixlafiles.awk-no_gcc_la fixlafiles.awk || die
			find "${D}/${LIBPATH}" -name libstdc++.la -type f -exec rm "{}" \;
		else
			doins "${GCC_FILESDIR}"/awk/fixlafiles.awk || die
		fi
		exeinto "${DATAPATH}"
		doexe "${GCC_FILESDIR}"/fix_libtool_files.sh || die
		doexe "${GCC_FILESDIR}"/c{89,99} || die
	fi

	# use gid of 0 because some stupid ports don't have
	# the group 'root' set to gid 0
	chown -R root:0 "${D}"${LIBPATH}

	# Move pretty-printers to gdb datadir to shut ldconfig up
	gdbdir=/usr/share/gdb/auto-load
	for module in $(find "${D}" -iname "*-gdb.py" -print); do
		insinto ${gdbdir}/$(dirname "${module/${D}/}" | \
				sed -e "s:/lib/:/$(get_libdir)/:g")
		doins "${module}"
		rm "${module}"
	done
}

