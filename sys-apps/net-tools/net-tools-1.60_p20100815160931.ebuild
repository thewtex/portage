# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60_p20100815160931.ebuild,v 1.8 2011/04/09 14:06:31 vapier Exp $

EAPI="3"

inherit flag-o-matic toolchain-funcs eutils

PATCH_VER="1"
DESCRIPTION="Standard Linux networking tools"
HOMEPAGE="http://net-tools.berlios.de/"
SRC_URI="mirror://gentoo/${P}.tar.xz
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls static"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/xz-utils"

maint_pkg_create() {
	cd /usr/local/src/net-tools/git
	#git-update
	local stamp=$(git log -n1 --pretty=format:%ai master | sed -e 's:[- :]::g' -e 's:+.*::')
	local pv="${PV/_p*}_p${stamp}"
	local p="${PN}-${pv}"
	git archive --prefix="nt/" master | tar xf - -C "${T}"
	pushd "${T}" >/dev/null
	pushd nt >/dev/null
	sed -i "/^RELEASE/s:=.*:=${pv}:" Makefile || die
	emake dist >/dev/null
	popd >/dev/null
	zcat ${p}.tar.gz | xz > ${p}.tar.xz
	rm -f ${p}.tar.gz
	popd >/dev/null

	local patches="${p}-patches-${PATCH_VER}"
	mkdir "${T}"/${patches}
	git format-patch -o "${T}"/${patches} master..gentoo > /dev/null
	tar cf - -C "${T}" ${patches} | xz > "${T}"/${patches}.tar.xz
	rm -rf "${T}"/${patches}

	du -b "${T}"/*.tar.xz
}

pkg_setup() { [[ -n ${VAPIER_LOVES_YOU} ]] && maint_pkg_create ; }

set_opt() {
	local opt=$1 ans
	shift
	ans=$("$@" && echo y || echo n)
	einfo "Setting option ${opt} to ${ans}"
	sed -i \
		-e "/^bool.* ${opt} /s:[yn]$:${ans}:" \
		config.in || die
}

src_prepare() {
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch "${WORKDIR}"/${P}-patches-${PATCH_VER}
}

src_configure() {
	set_opt I18N use nls
	set_opt HAVE_HWIB has_version '>=sys-kernel/linux-headers-2.6'
	if use static ; then
		append-flags -static
		append-ldflags -static
	fi
	tc-export AR CC
	yes "" | ./configure.sh config.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README README.ipv6 TODO
}

pkg_postinst() {
	einfo "etherwake and such have been split into net-misc/ethercard-diag"
}
