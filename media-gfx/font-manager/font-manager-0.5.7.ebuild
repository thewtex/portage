# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="A font management application for the GNOME desktop"
HOMEPAGE="http://code.google.com/p/font-manager"
SRC_URI="http://font-manager.googlecode.com/files/${P}.tar.bz2"
RESTRICT="mirror strip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls $(printf 'linguas_%s ' it ru sk)"

DEPEND="nls? ( sys-devel/gettext )
	>=dev-lang/python-2.6[sqlite]
	>=dev-python/pygtk-2
	>=dev-python/pygobject-2
	dev-python/pycairo
	dev-libs/libxml2[python]
	media-libs/fontconfig
	>=media-libs/freetype-2
	dev-db/sqlite:3
	x11-libs/gtk+:2"

RDEPEND="nls? ( virtual/libintl )"

src_prepare() {
	for h in it ru sk; do
		if ! use linguas_"${h}"; then
			rm -r po/"${h}".po
		fi
	done
}

src_configure() {
	econf \
	$( use_enable debug debuginfo ) \
	$( use_enable nls )
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO || die
}
