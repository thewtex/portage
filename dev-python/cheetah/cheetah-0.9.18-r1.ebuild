# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-0.9.18-r1.ebuild,v 1.2 2008/10/06 04:49:39 neurogeek Exp $

inherit distutils

MY_P=${P/ch/Ch}

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"
LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
DEPEND="virtual/python"
S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="Cheetah"
DOCS="README CHANGES TODO"

src_unpack(){
	distutils_src_unpack
	epatch "${FILESDIR}"/${MY_P}__future__imports.patch
}