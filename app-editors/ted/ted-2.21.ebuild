# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ted/ted-2.21.ebuild,v 1.9 2011/10/23 16:07:42 armin76 Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="X-based rich text editor"
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/tiff
	virtual/jpeg
	media-libs/libpng
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/Ted-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch

	sed -i -e 's|/Ted/|/share/Ted/|' \
		"${S}"/appFrame/appFrameConfig.h.in \
		"${S}"/Ted/tedConfig.h.in || die

	mkdir lib || die
}

src_configure() {
	tc-export CC

	local dir
	for dir in appFrame appUtil bitmap docBuf ind Ted tedPackage; do
		cd "${S}"/${dir}
		econf --cache-file=../config.cache || die "configure in ${dir} failed"
	done
}

src_compile() {
	emake package.shared
}

src_install() {
	cd tedPackage
	RPM_BUILD_ROOT=${D} ./installTed.sh COMMON || die

	dodir /usr/share
	mv "${ED}"usr/Ted "${ED}"usr/share/Ted
}
