# Copyright 2008-2011 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base

DESCRIPTION="A little program that is meant to encode/decode data to/from QR codes."
HOMEPAGE="http://kde-apps.org/content/show.php/KQRCode?content=143544"
SRC_URI="mirror://sourceforge/kqrcode/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-gfx/qrencode
	=kde-misc/kqrcode-dev-${PV}"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install

	dodoc AUTHORS INSTALL README VERSION
}
