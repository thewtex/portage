# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils git-2

DESCRIPTION="A curses media indexer and player for vi users"
HOMEPAGE="http://vitunes.org"
EGIT_REPO_URI="git://github.com/ryanflannery/vitunes.git"
EGIT_PROJECT="vitunes"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/taglib
		sys-libs/ncurses
		media-video/mplayer"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2-makefile.patch
	mv Makefile Makefile.bsd && mv Makefile.linux Makefile
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die
}

