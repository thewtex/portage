# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit autotools subversion

DESCRIPTION="A font management application for the GNOME desktop"
HOMEPAGE="http://code.google.com/p/font-manager"
ESVN_REPO_URI="http://font-manager.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.6[sqlite]
	>=dev-python/pygtk-2
	>=dev-python/pygobject-2
	dev-python/pycairo
	dev-libs/libxml2[python]
	media-libs/fontconfig
	>=media-libs/freetype-2
	dev-db/sqlite:3"

src_configure() {
	autoreconf -fvi
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	dodoc AUTHORS ChangeLog README TODO
}
