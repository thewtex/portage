# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgadmin3/pgadmin3-1.12.3.ebuild,v 1.2 2011/07/04 22:48:31 titanofold Exp $

EAPI=4

WX_GTK_VER="2.8"

inherit wxwidgets

DESCRIPTION="wxWidgets GUI for PostgreSQL."
HOMEPAGE="http://www.pgadmin.org/"
SRC_URI="mirror://postgresql/${PN}/release/v${PV}/src/${P}.tar.gz"

LICENSE="POSTGRESQL"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE="debug"

DEPEND="x11-libs/wxGTK:2.8[X]
	dev-db/postgresql-base
	>=dev-libs/libxml2-2.5
	>=dev-libs/libxslt-1.1"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--with-wx-version=2.8 \
		$(use_enable debug)
}

src_install() {
	default

	newicon "${S}/pgadmin/include/images/pgAdmin3.png" ${PN}.png

	# icon location for the desktop file provided in pkg folder
	insinto /usr/share/pgadmin3
	doins "${S}/pgadmin/include/images/pgAdmin3.png"

	domenu "${S}/pkg/pgadmin3.desktop"

	# Fixing world-writable files
	chmod -R go-w "${ED}/usr/share"
}
