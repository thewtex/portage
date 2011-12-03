# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit games

DESCRIPTION="SNES ROM utility with various functions"
HOMEPAGE="http://www.romhacking.net/utilities/401/"
SRC_URI="http://7clams.org/flora/distfiles/nsrt34l.tar.gz"

LICENSE="NSRT"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+ipsedit"
RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	dogamesbin nren nsrt || die
	dodoc nsrt.txt || die
	if use ipsedit; then
		dogamesbin ipsedit || die
	fi

	prepgamesdirs
}
