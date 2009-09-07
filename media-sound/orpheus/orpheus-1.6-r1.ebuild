# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/orpheus/orpheus-1.6-r1.ebuild,v 1.5 2009/09/06 17:53:56 ssuominen Exp $

EAPI=2
WANT_AUTOMAKE=1.8

inherit eutils autotools

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://konst.org.ua/en/orpheus"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/libvorbis
	media-sound/mpg123
	media-sound/vorbis-tools[ogg123]"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/1.5-amd64.patch

	# Fix a stack-based buffer overflow in kkstrtext.h in ktools library.
	# Bug 113683, CVE-2005-3863.
	epatch "${FILESDIR}"/101_fix-buffer-overflow.diff

	# configures generated by different autoconf versions
	# cause problems when calling econf
	cd "${S}/kkstrtext-0.1"
	eautoreconf
	cd "${S}/kkconsui-0.1"
	eautoreconf

	# force not using deprecated libghttp
	cd "${S}"
	epatch "${FILESDIR}"/${P}-nolibghttp.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
