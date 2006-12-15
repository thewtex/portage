# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Script to install ssh keys on local and remote servers."
HOMEPAGE="http://www.catb.org/~esr/ssh-installkeys"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/python-2.3"
RDEPEND="${DEPEND}"

src_install() {
	doman ${PN}.1
	dodoc COPYING README ${PN}.spec ${PN}.xml
	dobin ${PN}
}
