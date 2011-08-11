# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DEPEND="dev-libs/protobuf"
RDEPEND="${DEPEND}"

inherit eutils autotools

DESCRIPTION="C bindings for Google's Protocol Buffers"
HOMEPAGE="http://code.google.com/p/protobuf-c/"
SRC_URI="http://protobuf-c.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x64-macos"
IUSE="static-libs"
RESTRICT="strip"

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog

	use static-libs || rm -rf "${D}"/usr/lib*/*.la
}

