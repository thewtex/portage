EAPI="2"

inherit cmake-utils

DESCRIPTION="Enhanced external language binding for the Insight Toolkit."
HOMEPAGE="http://code.google.com/p/wrapitk/"
SRC_URI="http://wrapitk.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-doc python"

# wrapitk may require itk with USE doc or USE examples in order to compile, more
# investigation is required ....
RDEPEND="python? ( dev-lang/python )
  sci-libs/itk"
DEPEND="${RDEPEND}
  dev-lang/cableswig"


src_configure(){

# IUSE needed here...
	use python && mycmakeargs="${mycmakeargs}
			  -DWRAP_ITK_PYTHON:BOOL=ON
			  -DWRAP_unsigned_char:BOOL=ON
			  -DWRAP_signed_char:BOOL=ON
			  -DWRAP_unsigned_short:BOOL=ON
			  -DWRAP_signed_short:BOOL=ON
			  -DWRAP_float:BOOL=ON
			  -DWRAP_double:BOOL=ON
			  -DWRAP_complex_float:BOOL=ON
			  -DWRAP_complex_double:BOOL=ON
			  -DWRAP_vector_float:BOOL=ON
			  -DWRAP_vector_double:BOOL=ON"

	use doc && mycmakeargs="${mycmakeargs}
			  -DWRAP_ITK_DOC:BOOL=ON
			  -DWRAP_ITK_DOC_MAN:BOOL=ON"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}
