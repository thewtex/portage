# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P="${P/_rc/-RC}"
DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net"
SRC_URI="mirror://sourceforge/rpy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python
	>=dev-lang/R-2.3
	lapack? ( virtual/lapack )
	dev-python/numpy"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	S="${WORKDIR}"/${MY_P}
	cd "$S"
	sed -e "s:Rlapack:lapack:" -i setup.py || die "failed to fix lapack"
	epatch ${FILESDIR}/${P}-version-detect.patch
	epatch ${FILESDIR}/${P}-lib-handling.patch
}

src_compile() {
	cd $MY_P
	distutils_src_compile
}

src_install() {
	cd $MY_P
	distutils_src_install
	# add R libs to ld.so.conf
	doenvd "${FILESDIR}/90rpy"
}

pkg_postinst() {
	env-update
}
