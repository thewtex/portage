# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imageworsener/imageworsener-0.9.4.ebuild,v 1.2 2011/11/06 18:38:12 sping Exp $

EAPI="2"

inherit toolchain-funcs

MY_P="${PN}-src-${PV}"
MY_PN="imagew"

DESCRIPTION="Utility for image scaling and processing"
HOMEPAGE="http://entropymine.com/imageworsener/"
SRC_URI="http://entropymine.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng:0
	virtual/jpeg
	media-libs/libwebp"
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} "${S}/src/"*.c -lpng -ljpeg -lwebp -lm -lz -o \
		${MY_PN} || die "Compile failed."
}

src_install() {
	dobin ${MY_PN} || die "dobin failed."
	dodoc readme.txt technical.txt changelog.txt || die
}

src_test() {
	cd "${S}/tests" || die
	./runtest "${S}/${MY_PN}"
}
