# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ofono/ofono-0.50.ebuild,v 1.1 2011/06/16 09:48:35 dagger Exp $

EAPI="2"

inherit multilib systemd

DESCRIPTION="Open Source mobile telephony (GSM/UMTS) daemon."
HOMEPAGE="http://ofono.org/"
SRC_URI="mirror://kernel/linux/network/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="+atmodem bluetooth +caps +cdmamodem examples +isimodem +phonesim threads tools +udev"

RDEPEND=">=sys-apps/dbus-1.2.24
	>=dev-libs/glib-2.16
	bluetooth? ( >=net-wireless/bluez-4.61 )
	caps? ( sys-libs/libcap-ng )
	udev? ( >=sys-fs/udev-143 )
	examples? ( dev-python/dbus-python )
	tools? ( dev-libs/libusb:1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable caps capng) \
		$(use_enable threads) \
		$(use_enable udev) \
		$(use_enable isimodem) \
		$(use_enable atmodem) \
		$(use_enable cdmamodem) \
		$(use_enable bluetooth) \
		$(use_enable phonesim) \
		$(use_enable tools) \
		--enable-test \
		--localstatedir=/var \
		--with-systemdunitdir="$(systemd_get_unitdir)"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if ! use examples ; then
		rm -rf "${D}/usr/$(get_libdir)/ofono/test"
	fi

	if use tools ; then
		dobin tools/{auto-enable,huawei-audio} || die
	fi

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
	dodoc ChangeLog AUTHORS doc/*.txt
}
