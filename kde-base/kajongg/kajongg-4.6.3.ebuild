# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kajongg/kajongg-4.6.3.ebuild,v 1.5 2011/06/26 01:54:38 ranger Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta python

DESCRIPTION="The classical Mah Jongg for four players"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-db/sqlite:3
	$(add_kdebase_dep libkdegames)
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep libkmahjongg)
	>=dev-python/twisted-8.2.0
"
