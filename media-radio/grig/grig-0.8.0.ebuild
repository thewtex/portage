# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/grig/grig-0.8.0.ebuild,v 1.1 2011/08/31 07:13:01 tomjbe Exp $

EAPI=4

inherit eutils

DESCRIPTION="A tool for controlling amateur radios"
HOMEPAGE="http://groundstation.sourceforge.net/grig/"
SRC_URI="mirror://sourceforge/groundstation/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2
	media-libs/hamlib"
RDEPEND="${DEPEND}"

src_configure() {
	econf --enable-hardware
}

src_install() {
	default
	make_desktop_entry ${PN} "GRig" "/usr/share/pixmaps/grig/grig-logo.png" "Application;HamRadio"
	rm -rf "${D}/usr/share/grig" || die "cleanup docs failed"
}
