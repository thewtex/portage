# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcap-ng/libcap-ng-0.6.2.ebuild,v 1.14 2011/08/07 15:02:12 armin76 Exp $

EAPI="2"

inherit eutils autotools flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://people.redhat.com/sgrubb/libcap-ng/"
SRC_URI="http://people.redhat.com/sgrubb/libcap-ng/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE="python"

RDEPEND="sys-apps/attr
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	python? ( dev-lang/swig )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gentoo.patch
	eautoreconf

	use sparc && replace-flags -O? -O0
}

src_configure() {
	econf $(use_enable python) || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README
}
