# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/tnef/tnef-1.4.8.ebuild,v 1.4 2011/11/28 11:39:06 phajdan.jr Exp $

DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="mirror://sourceforge/tnef/${P}.tar.gz"
HOMEPAGE="http://world.std.com/~damned/software.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ~ppc ~ppc64 ~sparc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/man
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die
	doman doc/tnef.1 || die
}
