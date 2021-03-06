# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/innotop/innotop-1.7.2.ebuild,v 1.1 2010/01/31 07:32:31 robbat2 Exp $

inherit perl-app

DESCRIPTION="innotop - A text-mode MySQL and InnoDB monitor like mytop, but with many more features"
HOMEPAGE="http://code.google.com/p/innotop/"
SRC_URI="http://innotop.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	dev-perl/TermReadKey
	virtual/perl-Term-ANSIColor
	virtual/perl-Time-HiRes"

src_install() {
	perl-module_src_install
}
