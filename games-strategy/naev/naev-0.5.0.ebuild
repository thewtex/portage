# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/naev/naev-0.5.0.ebuild,v 1.3 2011/07/29 19:42:07 ssuominen Exp $

EAPI=2
inherit eutils gnome2-utils games

DESCRIPTION="A 2D space trading and combat game, in a similar vein to Escape Velocity"
HOMEPAGE="http://code.google.com/p/naev/"
SRC_URI="mirror://sourceforge/naev/${P}.tar.bz2
	mirror://sourceforge/naev/ndata-${PV}"

LICENSE="GPL-2 GPL-3 public-domain CCPL-Attribution-3.0 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +mixer +openal"

RDEPEND="media-libs/libsdl[X,audio,video]
	dev-libs/libxml2
	>=media-libs/freetype-2
	>=media-libs/libvorbis-1.2.1
	>=media-libs/libpng-1.4
	media-libs/sdl-image[png]
	virtual/glu
	virtual/opengl
	mixer? ( media-libs/sdl-mixer )
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${P}.tar.bz2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
}

src_configure() {
	egamesconf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_with openal) \
		$(use_with mixer sdlmixer)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		appicondir=/usr/share/icons/hicolor/32x32/apps \
		Graphicsdir=/usr/share/applications \
		install || die

	insinto "${GAMES_DATADIR}"/${PN}
	newins "${DISTDIR}"/ndata-${PV} ndata || die

	local res
	for res in 16 64 128 256; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins extras/logos/logo${res}.png naev.png || die
	done

	rm -f "${D}"/usr/share/doc/${PF}/LICENSE
	prepalldocs

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
