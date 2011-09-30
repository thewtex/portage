# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit toolchain-funcs git-2

DESCRIPTION="dmenu-ish universal notification system"
HOMEPAGE="https://github.com/knopwob/dunst"
EGIT_REPO_URI="git://github.com/knopwob/dunst.git"
EGIT_PROJECT="dunst"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="libnotify xinerama"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-apps/dbus
	xinerama? ( x11-libs/libXinerama )
	libnotify? ( x11-libs/libnotify )"

src_prepare() {
	sed -i \
		-e "s/CFLAGS   = -g -ansi -pedantic -Wall -Os/CFLAGS  += -g -ansi -pedantic -Wall/" \
		-e "s/LDFLAGS  = -s/LDFLAGS  += -g/" \
		-e "s/XINERAMALIBS  =/XINERAMALIBS  ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die "sed failed"
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC) || die "emake failed"
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" \
			|| die "emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	dodoc README
}
