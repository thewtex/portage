EAPI="2"

ECVS_USER="anonymous"
ECVS_SERVER="c3d.cvs.sourceforge.net:/cvsroot/c3d"
ECVS_MODULE="${PN}"

inherit eutils cvs cmake-utils

DESCRIPTION="A command-line companion to ITK-SNAP."
HOMEPAGE="http://www.itksnap.org/pmwiki/pmwiki.php?n=Convert3D.Convert3D"
#SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sci-libs/itk"
DEPEND="${RDEPEND}
  dev-util/cmake"

S="${WORKDIR}/${PN}"

src_unpack() {
	cvs_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}/0001-include-cstdio.patch" || die "patch failed"
}
