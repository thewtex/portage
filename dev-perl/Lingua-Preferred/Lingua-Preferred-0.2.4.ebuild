# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.4.ebuild,v 1.14 2010/02/04 14:16:55 tove Exp $

EAPI=2

MODULE_AUTHOR=EDAVIS
inherit perl-module

DESCRIPTION="Pick a language based on user's preferences"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 GPL-3 )" # GPL-2+
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Log-TraceMessages"
DEPEND="${RDEPEND}"
