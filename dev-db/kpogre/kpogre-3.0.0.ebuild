# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/kpogre/kpogre-3.0.0.ebuild,v 1.2 2009/11/11 12:05:20 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="KDE GUI for PostgreSQL."
HOMEPAGE="http://kpogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/kpogre/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libpqxx-3.0.0"
RDEPEND="${DEPEND}"

need-kde 3.5
