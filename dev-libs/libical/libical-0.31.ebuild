# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libical/libical-0.31.ebuild,v 1.1 2008/09/09 08:43:56 s4t4n Exp $

DESCRIPTION="a implementation of basic iCAL protocols from citadel, previously known as aurore."
HOMEPAGE="http://www.citadel.org"
SRC_URI="http://easyinstall.citadel.org/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TEST THANKS TODO doc/*.txt
}