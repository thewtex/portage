# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit autotools eutils games subversion

DESCRIPTION="Satirical console-based political role-playing/strategy game"
HOMEPAGE="http://sourceforge.net/projects/lcsgame/"
ESVN_REPO_URI="http://lcsgame.svn.sourceforge.net/svnroot/lcsgame/trunk"
ESVN_PROJECT="lcsgame"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="sys-libs/ncurses"

src_prepare() {
	# change the directory that's checked for art assets
	sed -i -e "s:usr/games/share:usr/share/games:" src/lcsio.cpp || die "sed failed"
	eautoreconf
}

src_configure() {
	econf
}

src_install() {
	dogamesbin src/crimesquad || die
	dodir "${GAMES_DATADIR}"/"${PN}"
	dodir "${GAMES_BINDIR}"
	insinto "${GAMES_DATADIR}"/"${PN}"/art
	doins -r art/* || die
	doman man/crimesquad.6
	dodoc AUTHORS ChangeLog LINUX_README.txt NEWS TODO docs/CrimeSquadManual.txt
	if use doc; then
		dodoc docs/cpcimageformat.txt docs/conventions.txt
	fi

	prepgamesdirs
}

pkg_postinst() {
	einfo "Since this game was originally coded for DOS, it has a screen"
	einfo "size of 80x25, whereas the default size of a typical terminal"
	einfo "emulator is 80x24. This may result in the last row of the"
	einfo "display being misplaced. Increase the size of your terminal by"
	einfo "one row to rectify this."
}
