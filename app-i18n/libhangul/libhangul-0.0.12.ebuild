# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libhangul/libhangul-0.0.12.ebuild,v 1.4 2011/10/01 03:20:09 phajdan.jr Exp $

EAPI="3"

DESCRIPTION="libhangul is a generalized and portable library for processing hangul."
HOMEPAGE="http://kldp.net/projects/hangul/"
SRC_URI="http://kldp.net/frs/download.php/5855/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls static-libs test"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	test? ( dev-libs/check )"

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable static-libs static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die
}
