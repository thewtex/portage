# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/srecord/srecord-1.57.ebuild,v 1.1 2011/09/03 10:40:17 radhermit Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="A collection of powerful tools for manipulating EPROM load files."
HOMEPAGE="http://srecord.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="static-libs test"

RDEPEND="dev-libs/libgcrypt"
DEPEND="${RDEPEND}
	dev-libs/boost
	sys-apps/groff
	test? ( app-arch/sharutils )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libtool.patch \
		"${FILESDIR}"/${P}-parallel-install.patch

	cp etc/configure.ac "${S}"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
