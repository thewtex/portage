# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xli/xli-1.17.0-r4.ebuild,v 1.6 2009/10/03 14:52:41 klausman Exp $

inherit eutils

SNAPSHOT="2005-02-27"
DESCRIPTION="X Load Image: view images or load them to root window"
HOMEPAGE="http://pantransit.reptiles.org/prog/"
SRC_URI="http://pantransit.reptiles.org/prog/xli/xli-${SNAPSHOT}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	>=sys-libs/zlib-1.1.4
	>=media-libs/libpng-1.0.5
	>=media-libs/jpeg-6b
	app-arch/bzip2"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-misc/imake
	app-text/rman
	!media-gfx/xloadimage
	!<media-gfx/xli-1.17.0-r3"

S=${WORKDIR}/${PN}-${SNAPSHOT}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i Imakefile \
		-e '/^DEFINES =/s/$/ -DHAVE_GUNZIP -DHAVE_BUNZIP2 /' \
		-e '/CCOPTIONS =/s/=.*/=/'

	# This is a hack to avoid a parse error on /usr/include/string.h
	# when _BSD_SOURCE is defined. This may be a bug in that header.
	sed	-i png.c \
		-e '/^#include "xli.h"/i#undef _BSD_SOURCE'

	# This hack will allow xli to compile using gcc-3.3
	sed -i rlelib.c \
		-e 's/#include <varargs.h>//'

	# fix potential security issues.
	EPATCH_OPTS="-F3 -l" epatch "${FILESDIR}"/xli-security-gentoo.diff

	# Fix scale per bug 282979
	epatch "${FILESDIR}"/${P}-fix-scale-zoom.patch
}

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin xli xlito || die

	dosym xli /usr/bin/xsetbg || die
	dosym xli /usr/bin/xview || die

	dodoc README README.xloadimage ABOUTGAMMA TODO chkgamma.jpg
	newman xli.man xli.1
	newman xliguide.man xliguide.1
	newman xlito.man xlito.1

	insinto /etc/X11/app-defaults
	newins "${FILESDIR}"/Xli.ad Xli
	fperms a+r /etc/X11/app-defaults/Xli
}
