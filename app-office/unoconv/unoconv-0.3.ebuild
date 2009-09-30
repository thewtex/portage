# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/storm/storm-0.13.ebuild,v 1.1 2008/10/26 05:04:25 neurogeek Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Convert between any document format supported by OpenOffice"
HOMEPAGE="http://dag.wieers.com/home-made/unoconv/"
SRC_URI="http://dag.wieers.com/home-made/unoconv/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	 || ( app-office/openoffice app-office/openoffice-bin )"
DEPEND="dev-python/setuptools"

src_prepare() {
	epatch "${FILESDIR}/0001-add-gentoo-path-to-pyuno.so.patch" || die "patching failed"
}

src_install() {
	emake install DESTDIR="${D}"
}
