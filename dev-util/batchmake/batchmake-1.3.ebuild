EAPI="2"

ECVS_SERVER="batchmake.org:/cvsroot/BatchMake"
ECVS_MODULE="BatchMake"
ECVS_BRANCH="BatchMake-1-3"
ECVS_USER="anoncvs"

inherit cvs cmake-utils multilib

DESCRIPTION="BatchMake is a cross platform tool for batch processing of large
amount of data."
HOMEPAGE="http://www.batchmake.org/"
#SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="sci-libs/itk"
DEPEND="dev-util/cmake
  ${RDEPEND}"

MY_PN="BatchMake"
S="${WORKDIR}/${MY_PN}"

src_unpack() {
	cvs_src_unpack
}

src_configure() {
	 if use examples; then
		 mycmakeargs="${mycmakeargs} -DBUILD_EXAMPLES:BOOL=ON" 
	 else
		 mycmakeargs="${mycmakeargs} -DBUILD_EXAMPLES:BOOL=OFF" 
	 fi
	 cmake-utils_src_configure
}


src_install() {
	cmake-utils_src_install

	cd "${D}/usr/lib"
	mv bmModuleDescriptionParser/libbmModuleDescriptionParser.so "$MY_PN" || die "library mv failed"
	cd "$S"
	echo "LDPATH=/usr/$(get_libdir)/${MY_PN}" >> "${T}/95${PN}"
	doenvd "${T}/95${PN}"

	if use examples; then
		cd "${D}/usr"
		mkdir -p share/doc/${PF}/
		mv examples share/doc/${PF}/
	fi
}
