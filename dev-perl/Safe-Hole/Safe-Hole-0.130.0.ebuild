# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Safe-Hole/Safe-Hole-0.130.0.ebuild,v 1.1 2011/08/29 09:30:29 tove Exp $

EAPI=4

MODULE_AUTHOR=TODDR
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="Exec subs in the original package from Safe"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
