# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.1.4-r2.ebuild,v 1.5 2009/02/12 01:51:19 carlo Exp $

EAPI="2"

ARTS_REQUIRED="never"

inherit kde

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org/"
SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="opengl gphoto2 ipod"

DEPEND="|| ( kde-base/libkcal:3.5 kde-base/kdepim:3.5 )
		>=media-libs/libkipi-0.1.5
		>=media-libs/libkexiv2-0.1.5
		~media-libs/libkdcraw-0.1.1
		gphoto2? ( >=media-libs/libgphoto2-2.3.1 )
		>=media-libs/imlib2-1.1.0[X]
		>=media-gfx/imagemagick-6.2.4
		>=media-video/mjpegtools-1.6.0
		opengl? ( x11-libs/qt:3[opengl] )
		>=media-libs/tiff-3.5
		>=dev-libs/libxslt-1.1
		ipod? ( =media-libs/libgpod-0.6* )"
RDEPEND="${DEPEND}
		media-sound/vorbis-tools
		virtual/mpg123"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Fixes an automagic dependency on libgpod. cf bug 191195.
	epatch "${FILESDIR}/${P}-ipod-191195.patch"

	epatch "${FILESDIR}/kipi-plugins-0.1.4-header.diff"

	rm -f "${S}"/configure
}

src_compile() {
	myconf="$(use_with opengl) $(use_with gphoto2) $(use_with ipod libgpod)"
	kde_src_compile all
}
