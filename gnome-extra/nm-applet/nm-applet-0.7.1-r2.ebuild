# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.7.1-r2.ebuild,v 1.1 2009/06/11 12:00:32 dagger Exp $

EAPI=2
inherit gnome2 eutils versionator autotools

PATCH_VERSION="1"

MY_P="${P/nm-applet/network-manager-applet}"
MYPV_MINOR=$(get_version_component_range 1-2)
PATCHNAME="${P}-gentoo-patches-${PATCH_VERSION}"

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="mirror://gnome/sources/network-manager-applet/0.7/${MY_P}.tar.bz2
	http://dev.gentoo.org/~dagger/files/${PATCHNAME}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~x86"
IUSE="cisco openvpn"

RDEPEND=">=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.9
	>=dev-libs/libnl-1.1
	=net-misc/networkmanager-${MYPV_MINOR}*
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	>=dev-libs/glib-2.16
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20
	cisco? ( net-misc/networkmanager-vpnc )
	openvpn? ( net-misc/networkmanager-openvpn )
	|| ( >=gnome-base/gnome-panel-2 xfce-base/xfce4-panel x11-misc/trayer )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
# USE_DESTDIR="1"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"

	if use openvpn && ! built_with_use net-misc/networkmanager-openvpn gnome ;
	then
		eerror ""
		eerror "To make use of the openvpn feature you have to compile"
		eerror "net-misc/networkmanager-openvpn with the \"gnome\" USE flag."
		eerror ""
		die "Fix use flag and re-emerge."
	fi
	if use cisco && ! built_with_use net-misc/networkmanager-vpnc gnome ; then
		eerror ""
		eerror "To make use of the cisco feature you have to compile"
		eerror "net-misc/networkmanager-vpnc with the \"gnome\" USE flag."
		eerror ""
		die "Fix use flag and re-emerge."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-confchanges.patch"
}

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/${PATCHNAME}"
	EPATCH_SUFFIX="patch"
	epatch && eautoreconf
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
