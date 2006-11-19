# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="https://svn.musicpd.org/mpc/trunk/"
inherit subversion eautogen-sh bash-completion

DESCRIPTION="A commandline client for Music Player Daemon (media-sound/mpd)"
HOMEPAGE="http://musicpd.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~fbsd ~ppc ~sparc ~alpha ~hppa ~mips"
IUSE="nls"

DEPEND="virtual/libc
	dev-util/gperf
	nls? ( || ( sys-libs/glibc dev-libs/libiconv ) )"

src_install() {
	mv -v doc/m3u-handler.sh doc/mpd-m3u-handler
	mv -v doc/pls-handler.sh doc/mpd-pls-handler
	dobin doc/mpd-m3u-handler
	dobin doc/mpd-pls-handler
	dobin src/mpc
	dodoc AUTHORS INSTALL README doc/mppledit

	dobashcompletion doc/mpc-bashrc
}
