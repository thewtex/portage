# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.8.4.ebuild,v 1.2 2011/08/26 20:00:04 nirbheek Exp $

EAPI="2"

inherit eutils gnome.org

# NetworkManager likes itself with capital letters
MY_PN="${PN/networkmanager/NetworkManager}"

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=dev-libs/dbus-glib-0.74
	net-misc/openconnect
	gnome? (
		>=x11-libs/gtk+-2.6:2
		gnome-base/gconf:2
		gnome-base/gnome-keyring
		gnome-base/libglade:2.0
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	ECONF="--disable-more-warnings
	--disable-static
	$(use_with gnome)
	$(use_with gnome authdlg)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS || die "dodoc failed"
}
