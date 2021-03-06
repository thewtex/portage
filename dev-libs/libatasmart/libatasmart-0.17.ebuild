# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libatasmart/libatasmart-0.17.ebuild,v 1.17 2011/04/04 15:25:36 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Lean and small library for ATA S.M.A.R.T. hard disks"
HOMEPAGE="http://0pointer.de/blog/projects/being-smart.html"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="static-libs"

RDEPEND="sys-fs/udev"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.17-strpool-uninit.patch
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README

	rm -rf "${D}"/usr/share/doc/${PN} || die
	find "${D}" -name '*.la' -exec rm -f {} +
}
