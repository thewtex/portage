# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Perl script for applying IPS patches to ROM images"
HOMEPAGE="http://www.zophar.net/utilities/patchutil/ips-pl.html"
SRC_URI="http://7clams.org/flora/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="dev-lang/perl"

src_install() {
	sed -i "s/modified/unmodified/" ips.pl
	dogamesbin ips.pl || die "dogamesbin failed"
	prepgamesdirs
}
