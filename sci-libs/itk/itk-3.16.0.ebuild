# Matt McCormick (thewtex) <matt@mmmccormick.com>
# created 2008 April 17

EAPI="2"

inherit cmake-utils multilib

MY_PN="InsightToolkit"
S="${WORKDIR}/${MY_PN}-${PV}"

DESCRIPTION="Insight Segmentation and Registration Toolkit (ITK)."
HOMEPAGE="http://itk.org/"
SRC_URI="http://downloads.sourceforge.net/itk/${MY_PN}-${PV}.tar.gz
	doc? ( http://downloads.sourceforge.net/itk/Doxygen${MY_PN}-${PV}.tar.gz )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples xml"

RDEPEND="x11-libs/libX11
		  x11-libs/libXt
		  virtual/opengl
		  media-libs/libpng
		  media-libs/tiff
		  sci-libs/fftw
		  !sci-libs/insighttoolkit
		  sys-libs/zlib
		  xml? ( dev-libs/libxml2 )
		  x11-libs/libXext" 

DEPEND="${RDEPEND}
	  >=dev-util/cmake-2.4"


src_prepare() {
	epatch "${FILESDIR}/itk-cmake-FindLibXml2.patch"
}

src_configure() {

	mycmakeargs="${mycmakeargs}
	 -DBUILD_SHARED_LIBS:BOOL=ON
	 -DUSE_FFTWD:BOOL=ON
     -DUSE_FFTWF:BOOL=ON
	 -DITK_USE_SYSTEM_PNG:BOOL=ON
     -DITK_USE_TEMPLATE_META_PROGRAMMING_LOOP_UNROLLING:BOOL=ON
	 -DITK_USE_SYSTEM_TIFF:BOOL=ON
	 -DITK_USE_SYSTEM_ZLIB:BOOL=ON
	 -DITK_USE_REVIEW:BOOL=ON"

	use xml && mycmakeargs="${mycmakeargs} -DITK_USE_SYSTEM_LIBXML2:BOOL=ON"

	 if use examples; then
		 mycmakeargs="${mycmakeargs} -DBUILD_EXAMPLES:BOOL=ON" 
	 else
		 mycmakeargs="${mycmakeargs} -DBUILD_EXAMPLES:BOOL=OFF" 
	 fi
	cmake-utils_src_configure

}


src_install() {

	cmake-utils_src_install

	cd "${S}"

	if use doc; then
		dohtml -r "${WORKDIR}/Doxygen${MY_PN}-${PV}" || die "Failed to install doxygen docs" 
		dohtml "${S}/README.html" || die "failed to install html doc"

		dodoc	"${S}"/Documentation/DeveloperList.txt			\
				"${S}"/Documentation/InsightDeveloperStart.doc	\
				"${S}"/Documentation/InsightDeveloperStart.pdf	\
				"${S}"/Documentation/README.html				\
				"${S}"/Documentation/Style.pdf					\
				"${S}"/Documentation/itk.ico

		docinto Doxygen
		dohtml	"${S}"/Documentation/Doxygen/*.dox				\
				"${S}"/Documentation/Doxygen/*.html				\
				"${S}"/Documentation/Doxygen/*.css

		docinto Art
		dodoc	"${S}"/Documentation/Art/*gif					\
				"${S}"/Documentation/Art/*jpg					\
				"${S}"/Documentation/Art/*psd					\
				"${S}"/Documentation/Art/*xpm

	fi

	# install the examples
	if use examples; then
		# Copy Example sources
		insinto /usr/share/${PN}/examples/src
		doins -r  ${S}/Examples/* ||	\
			die "Failed to copy example files"

		# copy binary examples
		exeinto /usr/share/${PN}/examples/bin 
		doexe ${CMAKE_BUILD_DIR}/bin/* || \
			die "Failed to copy binary example files"
		rm -rf ${D}/usr/share/${PN}/examples/bin/*.so* || \
			die "Failed to remove libraries from examples directory"
	fi


	echo "LDPATH=/usr/$(get_libdir)/${MY_PN}" >> "${T}/95${PN}"
	echo "ITK_DATA_ROOT=/usr/share/${PN}/data" >> ${T}/95${PN}
	doenvd "${T}/95${PN}"
}

pkg_postinst() {
	einfo "If you would like wrappers for interpreted"
	einfo "languages such as python, try installing"
	einfo "  sci-libs/wrapitk"
}
