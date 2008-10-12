# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-4.1.2.ebuild,v 1.1 2008/10/02 06:41:17 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdesdk
inherit kde4-meta

DESCRIPTION="Kate is an MDI texteditor"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook +plasma"

DEPEND="${DEPEND}
	>=kde-base/libplasma-${PV}:${SLOT}"
RDEPEND="${DEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"

src_unpack() {
	use htmlhandbook && KMEXTRA="doc/kate-plugins"
	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}