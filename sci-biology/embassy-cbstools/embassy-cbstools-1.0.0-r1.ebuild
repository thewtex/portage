# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-cbstools/embassy-cbstools-1.0.0-r1.ebuild,v 1.2 2010/01/15 22:44:35 fauli Exp $

EBOV="6.1.0"

inherit embassy

DESCRIPTION="EMBOSS wrappers for applications from the CBS group"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
