# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openvrml/openvrml-0.15.10.ebuild,v 1.10 2006/05/10 12:35:49 Exp $

inherit eutils

IUSE="java javascript jpeg nsplugin opengl png truetype truetype zlib"

DESCRIPTION="VRML97 library"
SRC_URI="mirror://sourceforge/openvrml/${P}.tar.gz"
HOMEPAGE="http://openvrml.org"

SLOT="0"
LICENSE="LGPL-2.1 GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"

RDEPEND="x11-base/xorg-x11
	gnome-base/libgnomeui
	net-misc/curl
	zlib? ( sys-libs/zlib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	truetype? ( media-libs/freetype media-libs/fontconfig )
	javascript? ( www-client/mozilla-firefox )
	nsplugin? ( www-client/mozilla-firefox )
	java? ( virtual/jdk )
	opengl? ( virtual/opengl virtual/glut )"

DEPEND="${RDEPEND}
	dev-libs/boost
	app-doc/doxygen"

# TODO: add support for java via libmozjs (http://www.mozilla.org/js/spidermonkey/)

src_unpack() {
	unpack ${A}
	cd "${S}"
	autoreconf --install --force
}


pkg_setup() {

	if use java ; then
		echo 
		ewarn "Java is currently unsupported in this version!"
		ewarn "Building openvrml with --disable-script-node-java."
		echo 
	fi

	if ! use jpeg || ! use png ; then
		einfo
		einfo "OpenVRML will *not* be built with ImageTexture support."
		einfo "Both 'png' and 'jpeg' must be enabled in USE flags for ImageTexture support."
		einfo
	fi
}

src_compile() {

	local myconf=""

	# Java is currently unsupported
	myconf="${myconf} --disable-script-node-java"

	use zlib \
		&& myconf="${myconf} --enable-gzip" \
		|| myconf="${myconf} --disable-gzip"

	use png && use jpeg \
		&& myconf="${myconf} --enable-imagetexture-node" \
		|| myconf="${myconf} --disable-imagetexture-node"

	use truetype \
		&& myconf="${myconf} --enable-text-node" \
		|| myconf="${myconf} --disable-text-node"

	use javascript \
		&& myconf="${myconf} --enable-script-node-javascript" \
		|| myconf="${myconf} --disable-script-node-javascript"

	use java \
		&& echo \
		   ewarn "Java is currently unsupported in this version!"
		   ewarn "Building openvrml with --disable-script-node-java."
		   echo 
#		&& myconf="${myconf} --enable-script-node-java --with-jdk=`java-config -O`" \
#		|| myconf="${myconf} --disable-script-node-java"

	use opengl \
		&& myconf="${myconf} --enable-gl-renderer --enable-lookat" \
		|| myconf="${myconf} --disable-gl-renderer --disable-lookat"

	use nsplugin \
		&& myconf="${myconf} --enable-mozilla-plugin" \
		|| myconf="${myconf} --disable-mozilla-plugin" 

	./configure --with-x --prefix=/usr ${myconf} || die "configure failed"

	make || die "make failed"

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS COPYING* ChangeLog INSTALL NEWS README THANKS

}
