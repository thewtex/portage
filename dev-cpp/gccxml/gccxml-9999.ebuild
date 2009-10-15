# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ECVS_USER="anoncvs"
ECVS_SERVER="www.gccxml.org:/cvsroot/GCC_XML"
ECVS_MODULE="gccxml"

inherit eutils cvs cmake-utils

DESCRIPTION="XML output extension to GCC"
HOMEPAGE="http://www.gccxml.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.6"
RDEPEND=""

EAPI="2"

S="${WORKDIR}/${PN}"

src_unpack() {
	cvs_src_unpack
}

src_prepare() {
	cd "${S}"
	# patch below taken from Debian
	sed -i \
		-e 's/xatexit.c//' \
		"${S}/GCC/libiberty/CMakeLists.txt" || die "sed failed"
}

