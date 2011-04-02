# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

DESCRIPTION="The Console Display Manager"
GITHUB_USER="golodhrim"
GITHUB_TAG="funtoo-${PV}"
HOMEPAGE="http://cdm.ghost1227.com/X11 https://github.com/${GITHUB_USER}/${PN}"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/${GITHUB_TAG} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="consolekit"

DEPEND="app-shells/bash"

RDEPEND="${DEPEND}
	dev-util/dialog
	x11-apps/xdpyinfo
	x11-apps/xinit
	consolekit? ( sys-auth/consolekit )"

src_prepare() {
	cd "${WORKDIR}"/${GITHUB_USER}-${PN}-*
	S="$(pwd)"

	if ! use consolekit
	then
		sed -i -e "/^consolekit=/s|yes|no|" src/cdmrc || die "sed failed"
	fi
}

src_install() {
	exeinto /usr/bin
	doexe src/cdm

	insinto /etc/X11/${PN}
	doins src/cdmrc src/xinitrc

	insinto /usr/share/${PN}
	doins src/zzz-cdm-profile.sh

	insinto /usr/share/${PN}/themes
	doins src/themes/*

	dodoc CHANGELOG
}

pkg_postinst() {
	ewarn "If you want cdm to be started automatically after login then"
	ewarn "move /usr/share/cdm/zzz-cdm-profile.sh to /etc/profile.d/."
}
