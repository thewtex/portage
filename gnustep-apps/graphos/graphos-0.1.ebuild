# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/graphos/graphos-0.1.ebuild,v 1.1 2010/06/28 15:17:18 voyageur Exp $

inherit eutils gnustep-2

MY_PN=Graphos
DESCRIPTION="vector drawing application centered around bezier paths"
HOMEPAGE="http://gap.nongnu.org/graphos/index.html"
SRC_URI="http://savannah.nongnu.org/download/gap/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${MY_PN}-${PV}
