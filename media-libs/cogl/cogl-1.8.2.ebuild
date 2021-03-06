# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cogl/cogl-1.8.2.ebuild,v 1.1 2011/10/28 21:56:11 tetromino Exp $

EAPI="4"
CLUTTER_LA_PUNT="yes"

# Inherit gnome2 after clutter to download sources from gnome.org
inherit clutter gnome2 virtualx

DESCRIPTION="A library for using 3D graphics hardware to draw pretty pictures"
HOMEPAGE="http://www.clutter-project.org/"

LICENSE="LGPL-2.1"
SLOT="1.0"
IUSE="doc examples +introspection +pango"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# XXX: need uprof for optional profiling support
COMMON_DEPEND=">=dev-libs/glib-2.26.0:2
	x11-libs/cairo
	>=x11-libs/gdk-pixbuf-2:2
	x11-libs/libdrm
	x11-libs/libX11
	>=x11-libs/libXcomposite-0.4
	x11-libs/libXdamage
	x11-libs/libXext
	>=x11-libs/libXfixes-3
	virtual/opengl

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	pango? ( >=x11-libs/pango-1.20.0[introspection?] )"
# before clutter-1.7, cogl was part of clutter
RDEPEND="${COMMON_DEPEND}
	!<media-libs/clutter-1.7"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.13 )"

# XXX: at least when using nvidia-drivers, tests fail under Xemake/Xvfb, no
# matter whether "eselect opengl" is set to nvidia or xorg-x11.
RESTRICT="test"

pkg_setup() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,*.jpg}"
	# XXX: think about gles, quartz, wayland
	G2CONF="${G2CONF}
		--disable-profile
		--disable-maintainer-flags
		--enable-cairo
		--enable-gdk-pixbuf
		--enable-gl
		--enable-glx
		$(use_enable introspection)
		$(use_enable pango cogl-pango)"
}

src_test() {
	Xemake check
}

src_install() {
	clutter_src_install
}
