# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/check/check-0.9.8-r1.ebuild,v 1.3 2011/12/02 23:49:01 hwoarang Exp $

EAPI=4
inherit autotools autotools-utils eutils

DESCRIPTION="A unit test framework for C"
HOMEPAGE="http://sourceforge.net/projects/check/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="static-libs subunit"

DEPEND="subunit? ( dev-python/subunit )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.9.6-AM_PATH_CHECK.patch \
		"${FILESDIR}"/${PN}-0.9.6-64bitsafe.patch

	sed -i -e '/^docdir =/d' {.,doc}/Makefile.am || die

	# fix out-of-sourcedir build having inconsistent check.h files, for
	# example breaks USE=subunit.
	rm src/check.h || die

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-dependency-tracking
		$(use_enable subunit)
		--docdir=/usr/share/doc/${PF}
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	dodoc AUTHORS *ChangeLog* NEWS README THANKS TODO

	rm -f "${D}"/usr/share/doc/${PF}/COPYING* || die
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
