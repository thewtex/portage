# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/taglib-extras/taglib-extras-9999.ebuild,v 1.9 2008/12/07 11:50:33 vapier Exp $

EAPI="2"

inherit cmake-utils subversion

ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/taglib-extras"

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug kde"

RDEPEND="
	>=media-libs/taglib-1.5
	kde? ( >=kde-base/kdelibs-4.1 )
	"
DEPEND="
	${RDEPEND}
	>=dev-util/cmake-2.6
	"

src_configure() {
	mycmakeargs="$(cmake-utils_use_with kde KDE)"
	cmake-utils_src_configure
}
