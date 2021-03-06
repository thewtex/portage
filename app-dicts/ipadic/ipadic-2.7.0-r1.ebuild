# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.7.0-r1.ebuild,v 1.1 2010/03/21 00:31:52 matsuu Exp $

EAPI="2"
inherit autotools eutils

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/chasen/distribution.html.en"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"

LICENSE="ipadic"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
IUSE=""

DEPEND=">=app-text/chasen-2.3.1"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die

	insinto /etc
	doins chasenrc || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
