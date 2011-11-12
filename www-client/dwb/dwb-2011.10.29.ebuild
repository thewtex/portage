# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Webkit-browser similar to vimprobable written in C"
HOMEPAGE="http://portix.bitbucket.org/dwb/"
SRC_URI="https://bitbucket.org/portix/dwb/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

DEPEND=""
RDEPEND="${DEPEND}
		!gtk3? (
			net-libs/webkit-gtk:2
			x11-libs/gtk+:2
		)
		gtk3? (
			net-libs/webkit-gtk:3
			x11-libs/gtk+:3
		)"

src_compile() {
	if use gtk3; then
		emake GTK=3
	else
		emake
	fi
}

src_install() {
		emake DESTDIR="${D}" install || die
}
