# Copyright 1999-2010 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/jnovy/pxz.git"
	inherit git
	SRC_URI=""
else
	# Remove a possible -Wl,--as-needed statement, pxz 4.9.999.9 is known to crash at build time with that option active.
	LDFLAGS="${LDFLAGS/-Wl,--as-needed}"
	MY_P="${PN}-${PV/_}"
	SRC_URI="http://jnovy.fedorapeople.org/pxz/${MY_P}.20091201git.tar.xz -> ${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~sparc ~x86"
	S=${WORKDIR}/${MY_P}

	# On the following architecture, pxz is known to compile but silent data corruption has been observed
	if [[ ${CFLAGS} =~ "-O3" ]]
	then
		case ${CHOST} in
			sparc*) abort_O3=yes ;;
	
		esac
	fi

	if [[ ${abort_O3} == yes ]]
	then
		die "Please do not use -O3 with this package, although ${P} compiles with that option on ${CHOST}, data corruption is known to occur.\nAlso the recompilation of app-arch/xz-utils with -O2 is *mandatory* to be used safely with this package."
	fi
		
fi

inherit eutils

DESCRIPTION="Parallel LZMA compressor/decompressor"
HOMEPAGE="http://jnovy.fedorapeople.org/pxz"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND=">=app-arch/xz-utils-4.999.9_beta"
DEPEND="${RDEPEND}"

src_install() {
	# Do not remove DESTDIR="${D}", else the package will try copy some files in /usr/bin resulting in a sandbox violation 
	emake install DESTDIR="${D}" || die
	#rm "${D}"/usr/share/doc/xz/COPYING* || die
	#mv "${D}"/usr/share/doc/{xz,${PF}} || die
	#prepalldocs
	#dodoc AUTHORS ChangeLog NEWS README THANKS
}
