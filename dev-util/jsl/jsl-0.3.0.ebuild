# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="Check your JavaScript source code for common mistakes"
HOMEPAGE="http://javascriptlint.com/"
SRC_URI="http://javascriptlint.com/download/${P}-src.tar.gz"

LICENSE="GPL-2 LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${P}/src"

DEPEND="sys-libs/readline"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-remove-termcap-link.patch
}

src_compile() {
	emake -j1 -f Makefile.ref JS_READLINE=1
}

src_install() {
	dobin Linux_All_DBG.OBJ/${PN}
}

pkg_postinst() {
	einfo "Run jsl -help:conf to get a sample config file"
	einfo "For further information, check http://javascriptlint.com/docs/index.htm"
}
