# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-tabpp/leechcraft-tabpp-0.4.90.ebuild,v 1.1 2011/09/14 17:06:19 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="Tab++ provides enhanced tab-related features like tab tree for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
