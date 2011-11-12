# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="Dark GTK+2 theme for Xfce"
HOMEPAGE="http://xfce-look.org/content/show.php?content=129706"
SRC_URI="http://7clams.org/flora/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND="x11-themes/gtk-engines-xfce
	x11-libs/gtk+:2"

RESTRICT="binchecks mirror strip"

S="${WORKDIR}"

src_install() {
	insinto "/usr/share/themes"
	doins -r Xfce-crash || die
}
