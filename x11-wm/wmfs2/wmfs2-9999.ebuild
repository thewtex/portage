# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils git

DESCRIPTION="Windows Manager From Scratch"
HOMEPAGE="https://www.wmfs.info"
EGIT_REPO_URI="git://git.wmfs.info/wmfs.git"
EGIT_PROJECT="wmfs2"
EGIT_BRANCH="wmfs2"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama xrandr imlib2 xft"

DEPEND="
	x11-libs/libX11
	x11-libs/libSM
	media-libs/freetype
	xft? ( x11-libs/libXft )
	imlib2? ( media-libs/imlib2 )
	xrandr? ( x11-libs/libXrandr )
	xinerama? ( x11-libs/libXinerama )
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	econf \
			$(use_with imlib2) \
			$(use_with xrandr) \
			$(use_with xinerama)
}

src_install() {
	cp ${S}/wmfs ${S}/${PN}
	cp ${S}/wmfs.1 ${S}/${PN}.1
	dobin  "${S}/${PN}" || die
	doman  "${S}/${PN}.1" || die
}
