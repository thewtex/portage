# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/net-http/net-http-0.3.1-r1.ebuild,v 1.3 2011/11/21 15:31:34 jlec Exp $

EAPI="3"

DESCRIPTION="Library for doing HTTP client-side programming in Guile"
HOMEPAGE="http://evan.prodromou.name/software/net-http/"
SRC_URI="http://evan.prodromou.name/software/net-http/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	# Scheme doesn't compile
	true
}

src_compile() {
	# Scheme doesn't compile
	true
}

src_install() {
	local GUILE_DIR="/usr/share/guile/site"
	insinto ${GUILE_DIR}
	doins -r "${S}"/net || die
	dodoc "${S}"/README || die
}
