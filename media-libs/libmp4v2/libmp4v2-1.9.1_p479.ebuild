# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp4v2/libmp4v2-1.9.1_p479.ebuild,v 1.1 2011/11/19 12:44:37 ssuominen Exp $

EAPI=4
inherit libtool versionator

MY_REV=$(get_version_component_range 4) ; MY_PV=${MY_REV/p/r} ; MY_P=${PN/lib}-trunk-${MY_PV}

DESCRIPTION="Functions for accessing ISO-IEC:14496-1:2001 MPEG-4 standard"
HOMEPAGE="http://code.google.com/p/mp4v2/"
SRC_URI="http://mp4v2.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="static-libs test utils"

RDEPEND=""
DEPEND="sys-apps/sed
	utils? ( sys-apps/help2man )
	test? ( dev-util/dejagnu )"

DOCS="doc/*.txt README"

S=${WORKDIR}/${MY_P}

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-gch \
		$(use_enable utils util) \
		$(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
