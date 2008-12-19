# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Libewf is a library for support of the Expert Witness Compression Format (EWF), it support both the SMART format (EWF-S01) and the EnCase format (EWF-E01). Libewf allows you to read and write media information within the EWF files."
HOMEPAGE="https://www.uitwisselplatform.nl/projects/libewf/"
SRC_URI="http://www.gentoo-quebec.org/index/Config_Mathieu/mirror/libewf/${P}.tar.gz"

LICENSE="LGPL, BSD"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-libs/zlib-1.2.3
        >=dev-libs/openssl-0.9.8"

src_compile() {
	econf
	emake || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}"
	dodoc ChangeLog README
}
