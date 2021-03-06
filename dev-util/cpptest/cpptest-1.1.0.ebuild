# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cpptest/cpptest-1.1.0.ebuild,v 1.9 2009/07/04 13:58:45 ranger Exp $

EAPI=2
inherit autotools

DESCRIPTION="Simple but powerful unit testing framework for C++"
HOMEPAGE="http://cpptest.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-htmldir.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc) \
		--htmldir=/usr/share/doc/${PF}/html/
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS BUGS NEWS README
}
