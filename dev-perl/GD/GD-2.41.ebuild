# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.41.ebuild,v 1.1 2008/09/10 17:12:12 tove Exp $

MODULE_AUTHOR=LDS
inherit eutils perl-module

DESCRIPTION="interface to Thomas Boutell's gd library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="animgif gif +jpeg +png truetype xpm"

DEPEND=">=media-libs/gd-2.0.3[jpeg?,png?,truetype?,xpm?]
	png? ( media-libs/libpng sys-libs/zlib )
	jpeg? ( media-libs/jpeg )
	truetype? ( =media-libs/freetype-2* )
	xpm? ( x11-libs/libXpm )
	gif? ( media-libs/giflib )
	dev-lang/perl"

SRC_TEST=do

src_compile() {
	myconf=""
	use gif && use animgif && myconf="${myconf},ANIMGIF"
	use jpeg && myconf="${myconf},JPEG"
	use truetype && myconf="${myconf},FREETYPE"
	use png && myconf="${myconf},PNG"
	use xpm && myconf="${myconf},XPM"
	use gif && myconf="${myconf},GIF"
	myconf="-options \"${myconf:1}\""
	perl-module_src_compile
}

mydoc="GD.html"
