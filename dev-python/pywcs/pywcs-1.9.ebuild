# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywcs/pywcs-1.9.ebuild,v 1.1 2010/10/12 23:08:42 bicatali Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

WCS_V=4.4.4
MYP="${P}-${WCS_V}"

DESCRIPTION="Python routines for handling the FITS World Coordinate System"
HOMEPAGE="https://trac6.assembla.com/astrolib/wiki http://www.scipy.org/AstroLib"
SRC_URI="http://stsdas.stsci.edu/astrolib/${MYP}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

COMMON_DEPEND=">=sci-astronomy/wcslib-${WCS_V}"
DEPEND="${COMMON_DEPEND}
	  dev-util/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	  dev-python/pyfits"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MYP}"

src_prepare(){
	epatch "${FILESDIR}"/${P}-wcslib.patch
}

src_test() {
	# FIX: does not work, needs fits files
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" test/test.py
	}
	python_execute_function testing
}

#FIX: compiles twice (once during build, another time during install)
# seems to be in the defsetup.py hack script
