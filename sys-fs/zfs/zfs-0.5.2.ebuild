# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils linux-mod
DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI="http://github.com/downloads/zfsonlinux/zfs/${P}.tar.gz"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

IUSE="selinux +blkid"
DEPEND="
	=sys-fs/spl-0.5.2
	selinux? ( sys-libs/libselinux )
	blkid? ( sys-libs/e2fsprogs-libs )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	linux-mod_pkg_setup
	linux_config_exists || die "Your kernel sources are unconfigured"
	MODULE_NAMES="zfs(addon/zfs/zfs/zfs.ko)"
	MODULE_NAMES="${MODULE_NAMES}:zunicode(addon/zfs/unicode/zunicode.ko)"
	MODULE_NAMES="${MODULE_NAMES}:zpios(addon/zfs/zpios/zpios.ko)"
	MODULE_NAMES="${MODULE_NAMES}:zavl(addon/zfs/avl/zavl.ko)"
	MODULE_NAMES="${MODULE_NAMES}:zcommon(addon/zfs/zcommon/zcommon.ko)"
	MODULE_NAMES="${MODULE_NAMES}:znvpair(addon/zfs/nvpair/znvpair.ko)"
}

src_configure() {
	local conf_opts
	conf_opts="--with-linux='$KV_DIR'"

	if (use selinux) ; then
		conf_opts="${conf_opts} --with-selinux"
	else
		conf_opts="${conf_opts} --without-selinux"
	fi

	if (use blkid) ; then
		conf_opts="${conf_opts} --with-blkid"
	else
		conf_opts="${conf_opts} --without-blkid"
	fi

	econf $conf_opts || die "configure failed"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_preinst() {
	find /lib/modules/${KV_FULL} -name 'zfs.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'zunicode.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'zpios.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'zavl.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'zcommon.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'znvpair.ko' -type f -delete

	linux-mod_pkg_preinst
}
