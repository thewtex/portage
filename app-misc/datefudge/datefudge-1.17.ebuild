# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/datefudge/datefudge-1.17.ebuild,v 1.1 2011/09/20 22:37:44 darkside Exp $

EAPI=4
inherit multilib toolchain-funcs

DESCRIPTION="A program (and preload library) to fake system date"
HOMEPAGE="http://packages.qa.debian.org/d/datefudge.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	sed -i \
		-e '/dpkg-parsechangelog/d' \
		-e "s:usr/lib:usr/$(get_libdir):" \
		-e 's:$(CC) -o:$(CC) $(LDFLAGS) -o:' \
		Makefile || die

	if use prefix; then
		sed -i -e '/-o root -g root/d' Makefile || die
	fi
}

src_compile() {
	tc-export CC
	emake VERSION="${PV}"
}

src_install() {
	emake DESTDIR="${ED}" VERSION="${PV}" install
	dodoc debian/changelog README
}
