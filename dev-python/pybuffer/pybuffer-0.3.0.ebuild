S="${WORKDIR}/wrapitk-${PV}"
CMAKE_USE_DIR="${S}/ExternalProjects/PyBuffer"

inherit cmake-utils

ESVN_REPO_URI="http://wrapitk.googlecode.com/svn/trunk/"

DESCRIPTION="Convert ITK images to numpy arrays and numpy arrays to ITK images."
HOMEPAGE="http://code.google.com/p/wrapitk/"
SRC_URI="http://wrapitk.googlecode.com/files/wrapitk-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
EAPI="2"

RDEPEND="dev-lang/python
  sci-libs/itk
  sci-libs/wrapitk"
DEPEND="${RDEPEND}"

