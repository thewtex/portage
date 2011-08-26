# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git linux-mod
DESCRIPTION="Solaris Porting Layer"
HOMEPAGE="http://zfsonlinux.org/"
EGIT_REPO_URI="https://github.com/zfsonlinux/spl.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"
DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	linux-mod_pkg_setup
	linux_config_exists || die "Your kernel sources are unconfigured"
	BUILD_TARGETS="all"
	MODULE_NAMES="spl(addon/spl/spl/spl.ko):splat(spl/splat)"
}

src_configure() {
	local conf_opts

	conf_opts="--with-linux=$KV_DIR"

	if has_multilib_profile && [[ "${DEFAULT_ABI}" == "x86" ]] ; then
		conf_opts="$conf_opts --arch=x86"
	fi

	./configure ${conf_opts} || die "configure failed"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_preinst() {
	find /lib/modules/${KV_FULL} -name 'spl.ko' -type f -delete
	find /lib/modules/${KV_FULL} -name 'splat.ko' -type f -delete

	linux-mod_pkg_preinst
}
