# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/greenbone-security-desktop/greenbone-security-desktop-1.2.0.ebuild,v 1.2 2011/10/22 22:30:00 hanno Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="GUI application for openvas"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/861/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-4
	x11-libs/qt-gui
	x11-libs/qt-webkit"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S="${WORKDIR}/gsd-${PV}"

src_prepare() {
	# else it'll need doxygen even without building docs
	sed -i 's/FATAL_ERROR/WARNING/' doc/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README TODO || die "dodoc failed"
}
