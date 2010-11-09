# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-2.1.5.ebuild,v 1.2 2008/09/02 04:22:03 mr_bones_ Exp $

inherit eutils

DESCRIPTION="grep for pdfs"
HOMEPAGE="http://pdfgrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="lcms"

RDEPEND="app-text/poppler"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
