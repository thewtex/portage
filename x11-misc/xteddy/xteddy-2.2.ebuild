# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xteddy/xteddy-2.2.ebuild,v 1.1 2011/11/19 04:20:20 radhermit Exp $

EAPI="4"

inherit autotools

DESCRIPTION="A cuddly teddy bear (or other image) for your X desktop"
HOMEPAGE="http://webstaff.itn.liu.se/~stegu/xteddy/"
SRC_URI="http://webstaff.itn.liu.se/~stegu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/imlib2
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS README ChangeLog NEWS xteddy.README )

src_prepare() {
	# Fix linking order for --as-needed
	sed -i -e "s/AM_LDFLAGS/xteddy_LDADD/" Makefile.am || die
	eautoreconf
}
