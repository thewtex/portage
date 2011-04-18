# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WX_GTK_VER="2.8"

inherit autotools eutils flag-o-matic subversion wxwidgets

DESCRIPTION="powerful open-source, cross platform IDE for the C/C++"
HOMEPAGE="http://www.codelite.org"
ESVN_REPO_URI="http://codelite.svn.sourceforge.net/svnroot/${PN}/trunk"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	sys-devel/libtool:1.5"
RDEPEND="${DEPEND}"

src_prepare() {
# Let's make the autorevision work.
	subversion_wc_info
	cur_rev=$(LC_ALL=C svn info "${ESVN_WC_PATH}" | grep Revision | awk '{print $2;}')
	echo "#include <wx/string.h>" > LiteEditor/svninfo.cpp
	printf "const wxChar * SvnRevision = wxT(\"%s\");\n" ${cur_rev} >> LiteEditor/svninfo.cpp
	echo "" >> LiteEditor/svninfo.cpp
	echo "Generating svninfo file..."
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
