# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="C++ computer vision library with emphasize on customizable algorithms and data structures"
HOMEPAGE="http://kogs-www.informatik.uni-hamburg.de/~koethe/vigra"
SRC_URI="http://kogs-www.informatik.uni-hamburg.de/~koethe/vigra/${P/-}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc fftw jpeg png tiff zlib"

RDEPEND=">=sys-devel/gcc-2.95.3
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	fftw? ( >=sci-libs/fftw-3 )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	dev-util/pkgconfig"

S="${WORKDIR}/${P/-}"

DOCS="README.txt"

MY_PREFIX="/usr"
MY_DOCDIR="${MY_PREFIX}/share/doc/${PF}"

src_compile() {
	./configure \
		--prefix="${MY_PREFIX}" \
		--docdir="${D}/${MY_DOCDIR}" \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with jpeg) \
		$(use_with zlib) \
		$(use_with fftw) \
	|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake prefix="${D}/usr" install || die "emake install failed"
	use doc || rm -Rf "${D}/${MY_DOCDIR}"
	dodoc ${DOCS}
}
