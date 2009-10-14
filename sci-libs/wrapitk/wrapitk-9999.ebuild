inherit cmake-utils subversion

ESVN_REPO_URI="http://wrapitk.googlecode.com/svn/trunk/"

DESCRIPTION="Enhanced external language binding for the Insight Toolkit."
HOMEPAGE="http://code.google.com/p/wrapitk/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"
EAPI="2"

# wrapitk may require itk with USE doc or USE examples in order to compile, more
# investigation is required ....
RDEPEND="python? ( dev-lang/python )
  sci-libs/itk"
DEPEND="${RDEPEND}
  dev-lang/cableswig"


src_configure(){

	use python && mycmakeargs="${mycmakeargs}
											  -DWRAP_ITK_PYTHON:BOOL=ON
											  -DWRAP_signed_short:BOOL=ON"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}
