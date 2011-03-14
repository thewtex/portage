# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-9999.ebuild,v 1.3 2011/03/14 09:45:03 scarabeus Exp $

EAPI=4

inherit eutils

DESCRIPTION="tool that helps you find what software is using the most power"
HOMEPAGE="http://www.lesswatts.org/projects/powertop/"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/status/powertop/powertop.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="unicode"

DEPEND="sys-libs/ncurses[unicode?]
	dev-libs/libnl
	sys-devel/gettext"
RDEPEND="${DEPEND}"

src_prepare() {
	use unicode || sed -i 's:-lncursesw:-lncurses:' Makefile
	# fix ldflags
	sed -i \
		-e 's:g++ $(OBJS) $(LIBS) -o powertop:$(CXX) $(LDFLAGS) $(OBJS) $(LIBS) -o powertop:' \
		-e 's:gcc:$(CC):' \
		Makefile || die
}

src_install() {
	emake install DESTDIR="${ED}"
	dodoc TODO README
	gunzip "${ED}"/usr/share/man/man1/powertop.1.gz
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the"
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)"
	echo
}
