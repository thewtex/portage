# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gupnp-dlna/gupnp-dlna-0.6.4.ebuild,v 1.1 2011/11/15 22:03:27 eva Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Library that provides DLNA-related functionality for MediaServers"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/libxml2-2.5:2
	>=media-libs/gstreamer-0.10.32:0.10
	>=media-libs/gst-plugins-base-0.10.32:0.10[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable introspection)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
