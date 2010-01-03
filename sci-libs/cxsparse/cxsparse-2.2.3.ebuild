# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cxsparse/cxsparse-2.2.3.ebuild,v 1.2 2010/01/02 18:11:27 fauli Exp $

EAPI=2
inherit autotools eutils

MY_PN=CXSparse
DESCRIPTION="Extended sparse matrix package."
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/CXSparse/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/versions/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""
DEPEND="sci-libs/ufconfig"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.2-autotools.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
}
