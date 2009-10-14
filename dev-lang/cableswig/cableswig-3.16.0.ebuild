inherit cmake-utils

MY_PN="CableSwig"
S="${WORKDIR}/${MY_PN}-ITK-${PV}"

DESCRIPTION="CableSwig is used to create wrappers to interpreted languages."
HOMEPAGE="http://www.itk.org/HTML/CableSwig.html"
SRC_URI="http://downloads.sourceforge.net/itk/${MY_PN}-ITK-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EAPI="2"

RDEPEND="dev-cpp/gccxml
  sys-devel/bison
  sys-devel/gcc
  dev-lang/swig"
DEPEND="${RDEPEND}
  dev-util/cmake"

src_configure() {
	mycmakeargs="-DCSWIG_USE_SYSTEM_GCCXML:BOOL=ON"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	exeinto /usr/bin
	cd "${CMAKE_BUILD_DIR}" || die "could not change to build directory" 
	doexe bin/{cableidx,cswig}
}
