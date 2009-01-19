# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit gnome2 eutils

MY_P="${P/nm-applet/network-manager-applet}"

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="mirror://gnome/sources/network-manager-applet/0.7/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~x86"
IUSE="cisco openvpn"

RDEPEND=">=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.9
	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-0.7.0
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	>=dev-libs/glib-2.16
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20
	>=gnome-base/gconf-2.20
	>=gnome-extra/policykit-gnome-0.8
	cisco? ( net-misc/networkmanager-vpnc )
	openvpn? ( net-misc/networkmanager-openvpn )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
# USE_DESTDIR="1"

S=${WORKDIR}/${P/_rc2/}

pkg_setup () {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"

	if use openvpn && ( ! built_with_use net-misc/networkmanager gnome || \
		! built_with_use net-misc/networkmanager-openvpn gnome ); then
		eerror ""
		eerror "To make use of the openvpn feature you have to compile"
		eerror "net-misc/networkmanager and net-misc/networkmanager-openvpn"
		eerror "with the \"gnome\" USE flag."
		eerror ""
		die "Fix use flag and re-emerge."
	fi
	if use cisco && ( ! built_with_use net-misc/networkmanager gnome || \
		! built_with_use net-misc/networkmanager-vpnc gnome ); then
		eerror ""
		eerror "To make use of the cisco feature you have to compile"
		eerror "net-misc/networkmanager and net-misc/networkmanager-vpnc"
		eerror "with the \"gnome\" USE flag."
		eerror ""
		die "Fix use flag and re-emerge."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.7.0-confchanges.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! built_with_use sys-auth/pambase gnome-keyring; then
		elog ""
		elog "To get rid of the password prompt for the gnome keyring you need"
		elog "to compile sys-apps/pambase with the gnome-keyring use flag and"
		elog "configure the pam settings of your login manager."
		elog ""
	fi

	elog "Your user needs to be in the plugdev group in order to use this"
	elog "package.  If it doesn't start in Gnome for you automatically after"
	elog 'you log back in, simply run "nm-applet --sm-disable"'
	elog "You also need the notification area applet on your panel for"
	elog "this to show up."
}
