# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug expat usb cups"

DEPEND="app-pda/libopensync
	=net-wireless/bluez-libs-3*
	usb? ( dev-libs/libusb )
	cups? ( net-print/cups )
	dev-libs/glib
	sys-apps/dbus"

src_compile() {
	econf \
		$(use_enable debug) \
		--enable-inotify \
		$(use_enable expat) \
		$(use_enable usb) \
		--enable-glib \
		--enable-obex \
		--enable-input \
		--enable-sync \
		--enable-hcid \
		--enable-sdpd \
		--enable-hidd \
		$(use_enable cups) \
		--enable-configfiles \
		--disable-initscripts \
		--enable-pcmciarules \
		--enable-bccmd \
		--enable-avctrl \
		--enable-hid2hci \
		--enable-dfutool \
		--localstatedir=/var \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README

	# optional bluetooth utils
	dosbin tools/hcisecfilter tools/ppporc
	dobin daemon/passkey-agent

	newinitd ${FILESDIR}/${PN}-2.25-init.d bluetooth
	newconfd ${S}/scripts/bluetooth.default bluetooth

	# bug #84431
	insinto /etc/udev/rules.d/
	newins ${FILESDIR}/${PN}-2.24-udev.rules 70-bluetooth.rules

	exeinto /lib/udev/
	newexe ${FILESDIR}/${PN}-2.24-udev.script bluetooth.sh
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		# check if root of init-process is identical to ours
		if [ -r /proc/1/root -a /proc/1/root/ -ef /proc/self/root/ ] ; then
			einfo "restarting udevd now."
			if [[ -n $(pidof udevd) ]] ; then
				killall -15 udevd &>/dev/null
				sleep 1
				killall -9 udevd &>/dev/null
			fi
			/sbin/udevd --daemon
		fi
	fi

	elog "If you use hidd, add --encrypt to the HIDD_OPTIONS in"
	elog "/etc/conf.d/bluetooth to secure your connection"
	elog
	elog "To use dund you must install net-dialup/ppp"
}
