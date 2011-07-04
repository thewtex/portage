# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://git.merovius.de/i3bar"
EGIT_BRANCH="master"

inherit git

DESCRIPTION="a small program for generating a status bar for dzen2, xmobar or
similiar programs"
HOMEPAGE="http://git.merovius.de/i3bar"
#SRC_URI="http://i3.zekjur.net/i3status/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/confuse"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
