# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-2.2.1.ebuild,v 1.1 2010/11/04 15:28:23 scarabeus Exp $

EAPI=3
inherit eutils qt4-r2

DESCRIPTION="A hierarchical notebook"
HOMEPAGE="http://www.tuxcards.de/"
SRC_URI="http://www.tuxcards.de/src/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	dobin ${PN} || die
	newicon src/icons/lo32-app-tuxcards.png ${PN}.png
	make_desktop_entry ${PN} TuxCards ${PN} "Qt;Utility"
	dodoc AUTHORS README || die
}
