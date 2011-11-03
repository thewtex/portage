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
dir=/opt/zachtronicsindustries/spacechem

pkg_nofetch() {
	einfo "Fetch ${SRC_URI} and put it into ${DISTDIR}. If this is your"
	einfo "first time installing SpaceChem, be sure to have your license"
	einfo "key close by, as the game will ask for it when first started."
	einfo "Purchase the game from http://spacechemthegame.com/"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	unpack "./SpaceChem-i386.deb"
	unpack ./data.tar.gz
}

src_install() {
	cd "${S}${dir}"
	insinto "${dir}"
	doins -r *.cer *.config *.exe *.dll template.* spacechem.* || die "doins failed"
	insinto "${dir}"/fonts 	&& doins -r fonts/* 	|| die "doins for fonts/ failed"
	insinto "${dir}"/images && doins -r images/* 	|| die "doins for images/ failed"
	insinto "${dir}"/lang 	&& doins -r lang/* 	|| die "doins for lang/ failed"
	insinto "${dir}"/music 	&& doins -r music/* 	|| die "doins for music/ failed"
	insinto "${dir}"/sounds && doins -r sounds/* 	|| die "doins for sounds/ failed"
	insinto "${dir}"/text 	&& doins -r text/* 	|| die "doins for text/ failed"
	exeinto "${dir}"
	doexe spacechem-launcher.sh || die "doexe failed"
	dodoc readme/LICENSE.txt readme/PRIVACY.txt readme/SOUND-CREDITS.txt
	domenu zachtronicsindustries-spacechem.desktop
	newicon icon.png zachtronicsindustries-spacechem.png

	prepgamesdirs
}
