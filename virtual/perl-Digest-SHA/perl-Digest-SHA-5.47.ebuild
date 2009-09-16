# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Digest-SHA/perl-Digest-SHA-5.47.ebuild,v 1.6 2009/09/15 06:32:06 tove Exp $

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Digest-SHA-${PV} )"
