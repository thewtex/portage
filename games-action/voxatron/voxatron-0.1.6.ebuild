# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit games eutils

DESCRIPTION="Action/adventure game set in a destructable world made of voxels"
HOMEPAGE="http://www.lexaloffle.com/voxatron.php"
SRC_URI="${PN}_${PV}_i386.tar.gz"

LICENSE="Voxatron"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"

RDEPEND=">=media-libs/libsdl-1.2
	media-libs/alsa-lib
	media-libs/mesa
	media-libs/libsndfile[-minimal]
	virtual/opengl
	x11-base/xorg-server[-minimal]
		amd64? (
	app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-opengl
	app-emulation/emul-linux-x86-sdl
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs )"

S="${WORKDIR}"/"${PN}"
dir="${GAMES_PREFIX_OPT}"/"${PN}"

pkg_nofetch() {
	einfo "Fetch ${SRC_URI} and put it into ${DISTDIR}"
	einfo "Purchase the game from http://www.lexaloffle.com/voxatron.php"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_install() {
	insinto "${dir}"
	doins -r vox.dat || die "doins failed"
	exeinto "${dir}"
	doexe vox || die "doexe failed"
	games_make_wrapper "${PN}" "${dir}/vox" "${dir}" "${dir}"
	doicon "${FILESDIR}"/voxatron.png
	make_desktop_entry "${PN}" "Voxatron" "${PN}" "Game;ActionGame;AdventureGame" "Comment=${DESCRIPTION}"
	dodoc vox.txt
	prepgamesdirs
}
