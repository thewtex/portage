# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/rply/rply-1.01-r1.ebuild,v 1.1 2011/10/28 20:41:32 tetromino Exp $

EAPI="4"

inherit cmake-utils

DESCRIPTION="A library to read and write PLY files"
HOMEPAGE="http://w3.impa.br/~diego/software/rply/"
SRC_URI="http://w3.impa.br/~diego/software/rply/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	use doc && HTML_DOCS="manual/*"
}

src_prepare() {
	# rply doesn't have *any* build system - not even a Makefile!
	# For simplicity, use the cmake file that Fedora maintainers have created
	cp "${FILESDIR}/rply_CMakeLists.txt" CMakeLists.txt
	mkdir -p CMake/export

	# Use int16_t and int32_t instead of assuming e.g. that sizeof(long) == 4
	epatch "${FILESDIR}/${P}-stdint.h.patch"

	# Switch LC_NUMERIC locale to "C" to ensure "." is the decimal separator
	epatch "${FILESDIR}/${P}-lc_numeric.patch"
}
