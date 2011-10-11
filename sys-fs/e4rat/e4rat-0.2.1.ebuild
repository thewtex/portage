# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Toolset to accelerate the boot process as well as application startups"
HOMEPAGE="http://e4rat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/cmake
		>=dev-libs/boost-1.41[static-libs]
		sys-fs/e2fsprogs
		sys-process/audit"
RDEPEND="${DEPEND}"

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX="${DE}" -DCMAKE_BUILD_TYPE=release || die 'Configure failed'
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die 
}

pkg_postinst() {
	ewarn "E4rat is designed for ext4 only and requires Linux-2.6.31 or newer."
}
