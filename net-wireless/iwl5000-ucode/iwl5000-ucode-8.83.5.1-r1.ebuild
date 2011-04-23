# Copyright 1999-2011 Gentoo Foundation
# Copyright 2011 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# Override of the original Gentoo ebuild net-wireless/iwl5000-ucode-8.83.5.1 

EAPI="3"
inherit linux-info
MY_PN="iwlwifi-5000-ucode"
MY_PV="${PV/0/A}"

DESCRIPTION="Intel (R) Wireless WiFi Link 5100/5300 ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${MY_PV}.tgz"

LICENSE="ipw3945"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

# see Gentoo bug #359445, iwl5000-ucode-8.83.5.1 requires a Linux kernel >= 2.6.38
DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 ) >=sys-kernel/gentoo-sources-2.6.38"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

pkg_setup() {
	kernel_is ge 2 6 38 || die "A kernel older than Linux 2.6.38 has been detected in /usr/src/linux. Please do not use this package with a Linux kernel <= 2.6.38, ABI incompatibilities will prevent the firmware from being loaded and your wireless adapter to function properly. See Gentoo bug #359445"
}

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-5000-5.ucode" || die

	dodoc README* || die "dodoc failed"
}
