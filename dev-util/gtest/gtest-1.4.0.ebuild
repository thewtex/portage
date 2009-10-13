# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Google's framework for writing C++ tests."
HOMEPAGE="http://code.google.com/p/googletest/"
SRC_URI="http://googletest.googlecode.com/files/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_prepare() {
	# threadsafety tests fail within the sandbox with
	# a segfault in libsandbox or ld.so but work without the sandbox
	epatch "${FILESDIR}/${PN}-false_test_failures.patch"

	sed -i -e "s|/tmp|${T}|g" test/gtest-filepath_test.cc || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGES CONTRIBUTORS README

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*.{cc,h}
	fi
}
