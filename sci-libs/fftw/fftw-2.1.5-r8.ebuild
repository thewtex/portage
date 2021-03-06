# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-2.1.5-r8.ebuild,v 1.11 2011/06/24 10:58:37 jlec Exp $

EAPI="3"

inherit autotools eutils flag-o-matic fortran-2 toolchain-funcs

DESCRIPTION="Fast C library for the Discrete Fourier Transform"
SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"

DEPEND="
	fortran? ( virtual/fortran )
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

SLOT="2.1"
LICENSE="GPL-2"
IUSE="doc float fortran mpi openmp threads"

KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

pkg_setup() {
	use openmp && FORTRAN_NEED_OPENMP="1"
	use fortran && fortran-2_pkg_setup
	# this one is reported to cause trouble on pentium4 m series
	filter-mfpmath "sse"

	# here I need (surprise) to increase optimization:
	# --enable-i386-hacks requires -fomit-frame-pointer to work properly
	if use x86; then
		is-flag "-fomit-frame-pointer" || append-flags "-fomit-frame-pointer"
	fi
	if use openmp && [[ $(tc-getCC) == *gcc* ]] && ! $(tc-has-openmp); then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		ewarn "If you want to build fftw with OpenMP, abort now,"
		ewarn "and switch CC to an OpenMP capable compiler"
		ewarn "Otherwise the configure script will select POSIX threads."
	fi
	use openmp && [[ $(tc-getCC)$ == icc* ]] && append-ldflags $(no-as-needed)
}

src_prepare() {
	# doc suggests installing single and double precision versions
	#  via separate compilations. will do in two separate source trees
	# since some sed'ing is done during the build
	# (?if --enable-type-prefix is set?)

	epatch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-configure.in.patch \
		"${FILESDIR}"/${P}-no-test.patch \
		"${FILESDIR}"/${P}-cc.patch

	# fix info files
	for infofile in doc/fftw*info*; do
		cat >> ${infofile} <<-EOF
			INFO-DIR-SECTION Libraries
			START-INFO-DIR-ENTRY
			* fftw: (fftw).				${DESCRIPTION}
			END-INFO-DIR-ENTRY
		EOF
	done

	eautoreconf

	cd "${WORKDIR}"
	cp -R ${P} ${P}-double
	mv ${P} ${P}-single
}

src_configure() {
	local myconf="
		--enable-shared
		--enable-type-prefix
		--enable-vec-recurse
		$(use_enable fortran)
		$(use_enable mpi)
		$(use_enable x86 i386-hacks)"
	if use openmp; then
		myconf="${myconf}
			--enable-threads
			--with-openmp"
	elif use threads; then
		myconf="${myconf}
			--enable-threads
			--without-openmp"
	else
		myconf="${myconf}
			--disable-threads
			--without-openmp"
	fi
	cd "${S}-single"
	econf ${myconf} \
		--enable-float \
		--with-gcc=$(tc-getCC)

	cd "${S}-double"
	econf ${myconf} \
		--with-gcc=$(tc-getCC)
}

src_compile() {
	local dir
	for dir in "${S}-single" "${S}-double"
	do
		einfo "Running compilation in ${dir}"
		cd ${dir}
		emake || die "emake failed in ${dir}"
	done
}

src_test() {
	local dir
	for dir in "${S}-single" "${S}-double"
	do
		einfo "Running tests in ${dir}"
		cd ${dir}
		emake -j1 check || die "test failed in ${dir}"
	done
}

src_install () {
	# both builds are installed in the same place
	# libs are distinguished by prefix (s or d), see docs for details

	local dir
	for dir in "${S}-single" "${S}-double"
	do
		cd ${dir}
		emake DESTDIR="${D}" install || die "installation failed in ${dir}"
	done

	insinto /usr/include
	doins fortran/fftw_f77.i || die "doins failed"
	dodoc AUTHORS ChangeLog NEWS TODO README README.hacks || die "dodoc failed"
	use doc && dohtml doc/*

	if use float; then
		for f in "${ED}"/usr/{include,$(get_libdir)}/*sfft*; do
			ln -s $(basename ${f}) ${f/sfft/fft}
		done
		for f in "${ED}"/usr/{include,$(get_libdir)}/*srfft*; do
			ln -s $(basename ${f}) ${f/srfft/rfft}
		done
	else
		for f in "${ED}"/usr/{include,$(get_libdir)}/*dfft*; do
			ln -s $(basename ${f}) ${f/dfft/fft}
		done
		for f in "${ED}"/usr/{include,$(get_libdir)}/*drfft*; do
			ln -s $(basename ${f}) ${f/drfft/rfft}
		done
	fi
}
