# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/eblook/eblook-1.5.1.ebuild,v 1.11 2008/06/18 02:38:29 darkside Exp $

inherit eutils autotools

IUSE=""

DESCRIPTION="EBlook is an interactive search utility for electronic dictionaries"
HOMEPAGE="http://openlab.ring.gr.jp/edict/eblook/"
SRC_URI="http://openlab.ring.gr.jp/edict/eblook/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="!>=dev-libs/eb-4.1
	>=dev-libs/eb-3.3.4"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.53"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-eb4-gentoo.diff"
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
