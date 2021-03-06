# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpon/arpon-2.1-r1.ebuild,v 1.3 2011/08/07 13:48:14 armin76 Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="ArpON (Arp handler inspectiON) is a portable Arp handler."

MY_PN="ArpON"
MY_P="${MY_PN}-${PV}"
HOMEPAGE="http://arpon.sourceforge.net/"
SRC_URI="mirror://sourceforge/arpon/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libdnet
	net-libs/libnet:1.1
	net-libs/libpcap"

RDEPEND=${DEPEND}

S="${WORKDIR}"/${MY_P}

src_prepare() {
	sed -i -e "s:-Wall.*-ggdb::" CMakeLists.txt || die
}
