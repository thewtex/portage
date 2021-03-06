# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lingot/lingot-0.9.0.ebuild,v 1.3 2011/06/12 08:48:42 radhermit Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="LINGOT Is Not a Guitar-Only Tuner"
HOMEPAGE="http://www.nongnu.org/lingot"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack"

RDEPEND="x11-libs/gtk+:2
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	dev-libs/glib:2
	gnome-base/libglade:2.0
	alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.102 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7.6-clean-install.patch \
		"${FILESDIR}"/${P}-jack.patch

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable alsa) \
		$(use_enable jack)
}

src_install() {
	emake DESTDIR="${D}" lingotdocdir="/usr/share/doc/${PF}" install
}
