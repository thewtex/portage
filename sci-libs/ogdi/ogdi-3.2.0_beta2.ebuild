# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ogdi/ogdi-3.2.0_beta2.ebuild,v 1.2 2011/06/17 11:00:15 scarabeus Exp $

EAPI=4

MY_P=${P/_/.}
inherit eutils toolchain-funcs

DESCRIPTION="Open Geographical Datastore Interface, a GIS support library"
HOMEPAGE="http://ogdi.sourceforge.net"
SRC_URI="mirror://sourceforge/ogdi/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="static-libs"

DEPEND="
	dev-libs/expat
	sci-libs/proj
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	rm -rf external
	epatch \
		"${FILESDIR}"/${P}-subdirs.patch \
		"${FILESDIR}"/${P}-endianess.patch \
		"${FILESDIR}"/${P}-64b.patch \
		"${FILESDIR}"/${PN}-3.1.6-fpic.patch
	sed 's:O2:O9:g' -i configure || die
}

src_configure() {
	export TOPDIR="${S}"
	export TARGET=`uname`
	export CFG="release"
	export LD_LIBRARY_PATH=$TOPDIR/bin/${TARGET}

	econf \
		--with-projlib="-L${EPREFIX}/usr/$(get_libdir) -lproj" \
		--with-zlib --with-expat
}

src_compile() {
	# bug #299239
	emake -j1 \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		SHLIB_LD="$(tc-getCC)"
}

src_install() {
	mv "${S}"/bin/${TARGET}/*.so* "${S}"/lib/Linux/. || die "lib move failed"
	dobin "${S}"/bin/${TARGET}/*
	insinto /usr/include
	doins ogdi/include/ecs.h ogdi/include/ecs_util.h
	dolib.so lib/${TARGET}/lib*
	use static-libs && dolib.a lib/${TARGET}/static/*.a
#	dosym libogdi31.so /usr/$(get_libdir)/libogdi.so || die "symlink failed"
	dodoc ChangeLog NEWS README
}
