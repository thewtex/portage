# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-data/doom3-data-1.1.1282-r1.ebuild,v 1.6 2009/10/03 22:44:51 nyhm Exp $

inherit eutils games

DESCRIPTION="Doom 3 - data portion"
HOMEPAGE="http://www.doom3.com/"
SRC_URI=""

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
PROPERTIES="interactive"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"

src_install() {
	cdrom_get_cds \
		Setup/Data/base/pak002.pk4 \
		Setup/Data/base/pak000.pk4 \
		Setup/Data/base/pak003.pk4

	insinto "${GAMES_PREFIX_OPT}"/doom3/base

	einfo "Copying files from CD 1..."
	doins "${CDROM_ROOT}"/Setup/Data/base/pak002.pk4 \
		|| die "doins pak002.pk4 failed"

	cdrom_load_next_cd
	einfo "Copying files from CD 2..."
	doins "${CDROM_ROOT}"/Setup/Data/base/pak00{0,1}.pk4 \
		|| die "doins pak00{0,1}.pk4 failed"

	cdrom_load_next_cd
	einfo "Copying files from CD 3..."
	doins "${CDROM_ROOT}"/Setup/Data/base/pak00{3,4}.pk4 \
		|| die "doins pak00{3,4}.pk4 failed"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "This is just the data portion of the game. You will need to install"
	elog "games-fps/doom3 to play the game."
}
