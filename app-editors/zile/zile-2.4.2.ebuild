# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/zile/zile-2.4.2.ebuild,v 1.4 2011/11/29 12:04:19 naota Exp $

EAPI=4

DESCRIPTION="Zile is a small Emacs clone"
HOMEPAGE="http://www.gnu.org/software/zile/"
SRC_URI="mirror://gnu/zile/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="acl test"

RDEPEND="dev-libs/boehm-gc
	sys-libs/ncurses
	acl? ( virtual/acl )"

DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--disable-silent-rules \
		$(use_enable acl)
}

src_install() {
	emake DESTDIR="${D}" install

	# AUTHORS, FAQ, and NEWS are installed by the build system
	dodoc README THANKS

	# Zile should never install charset.alias (even on non-glibc arches)
	rm -f "${ED}"/usr/lib/charset.alias
}
