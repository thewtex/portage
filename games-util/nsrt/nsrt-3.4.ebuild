# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="SNES ROM utility with various functions. Includes ipsedit and nren"
HOMEPAGE="http://www.romhacking.net/utilities/401/"
SRC_URI="http://7clams.org/flora/distfiles/${P}.tar.gz"

LICENSE="NSRT"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	dogamesbin ipsedit nren nsrt || die "dogamesbin failed"
	dodoc nsrt.txt || die "dodoc failed"
	prepgamesdirs
}
