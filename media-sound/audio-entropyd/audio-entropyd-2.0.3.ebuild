# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audio-entropyd/audio-entropyd-2.0.3.ebuild,v 1.1 2011/04/18 15:08:28 angelos Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Audio-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/aed/"
SRC_URI="http://www.vanheusden.com/aed/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="selinux"

RDEPEND="selinux? ( sec-policy/selinux-audio-entropyd )
	media-sound/alsa-utils"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0.1-uclibc.patch" \
		"${FILESDIR}/${PN}-2.0.1-ldflags.patch"
	sed -i -e "s:^OPT_FLAGS=.*:OPT_FLAGS=${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dosbin audio-entropyd
	dodoc README TODO
	newinitd "${FILESDIR}/${PN}.init-2" ${PN}
	newconfd "${FILESDIR}/${PN}.conf-2" ${PN}
}
