# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games eutils

DESCRIPTION="Design-based puzzle game about building machines by synthesizing chemicals"
HOMEPAGE="http://spacechemthegame.com/"
SRC_URI="SpaceChem-1011.tar.gz"

LICENSE="SPACECHEM"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"

RDEPEND=">=dev-lang/mono-2
	x11-misc/xclip
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
		amd64? (
	app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Fetch ${SRC_URI} and put it into ${DISTDIR}"
	einfo "Purchase the game from http://spacechemthegame.com/"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	unpack "./SpaceChem-i386.deb"
	unpack ./data.tar.gz
}

src_install() {
	dodir "/${GAMES_PREFIX_OPT}/${PN}/"
	cd "${S}/opt/zachtronicsindustries/spacechem/"
	cp -R . "${D}/${GAMES_PREFIX_OPT}/${PN}"

	newicon icon.png "${PN}.png"
	games_make_wrapper "${PN}" "mono SpaceChem.exe" "${ROOT}/${GAMES_PREFIX_OPT}/${PN}/"
	make_desktop_entry "${PN}" "SpaceChem" "${PN}" "Game;LogicGame;" "Comment=Solve design-based challenges in this game from Zachtronics Industries"

	prepgamesdirs
}
