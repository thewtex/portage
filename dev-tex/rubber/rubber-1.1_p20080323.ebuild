# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/rubber/rubber-1.1_p20080323.ebuild,v 1.3 2009/09/10 17:01:16 patrick Exp $

EAPI="2"
NEED_PYTHON="2.5"

inherit distutils eutils

IUSE=""

MY_P=${PN}-${PV/*_p/}

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="http://iml.univ-mrs.fr/~beffara/soft/rubber/"
SRC_URI="http://iml.univ-mrs.fr/~beffara/soft/rubber/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/latex-base"

S=${WORKDIR}/${P/_p*/}

src_prepare() {
	epatch "${FILESDIR}/rubber-python2.6.patch"
}

src_compile() {
	# configure script is not created by GNU autoconf
	./configure --prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die
	emake || die
}
