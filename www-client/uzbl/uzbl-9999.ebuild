# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
inherit git
 
EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"
 
DESCRIPTION="Uzbl: a keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI=""
 
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dmenu socat xclip zenity"
 
RDEPEND=">=net-libs/webkit-gtk-1.1.7
         >=net-libs/libsoup-2.26.2
         >=x11-libs/gtk+-2.14
         >=dev-libs/icu-4.0.1
         dmenu? (
             x11-misc/dmenu
         )
         socat? (
             net-misc/socat
         )
         xclip? (
             x11-misc/xclip
         )
         zenity? (
             gnome-extra/zenity
)"
 
DEPEND="${RDEPEND}
        >=dev-util/pkgconfig-0.19
"
 
src_install() {
# The Makefile appends '/usr/local' to DESTDIR to get PREFIX, so we simply
# set PREFIX ourself.
emake PREFIX="${D}/usr" install || die "Installation failed"
# Move the docs to /usr/share/doc instead.
dodoc AUTHORS README docs/*
# Move the config.h to /usr/share/uzbl instead.
mv "${D}/usr/share/uzbl/docs/config.h" "${D}/usr/share/uzbl"
# Remove the docs/ directory, we have everything we need.
rm -rf "${D}/usr/share/uzbl/docs"
}
 
