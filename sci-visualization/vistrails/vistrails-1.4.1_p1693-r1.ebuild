EAPI="2"

inherit versionator python

MY_PV="${PV/_p/-rev}"
USERGUIDE_VERSION="1.3-rev198"

DESCRIPTION="VisTrails is a scientific workflow and provenance management system that provides support for data exploration and visualization."
HOMEPAGE="http://vistrails.org/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/v$(get_version_component_range 1-3)/${PN}-src-${MY_PV}.tar.gz
  doc? ( http://sourceforge.net/projects/vistrails/files/vistrails/vistrails-usersguide-${USERGUIDE_VERSION}.pdf )
  examples? ( http://www.vistrails.org/download/download.php?id=data.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="itk +imagemagick +matplotlib scipy +vtk doc examples"

DEPEND="${DEPEND}"
RDEPEND="dev-python/PyQt4
  dev-python/numpy
  matplotlib? ( dev-python/matplotlib )
  imagemagick? ( media-gfx/imagemagick )
  scipy? ( sci-libs/scipy )
  vtk? ( sci-libs/vtk[python,qt4] )
  x11-libs/qt-gui:4"

S="${WORKDIR}/${PN}-src-${MY_PV}"

src_install() {

	if ! use matplotlib; then
		rm -rf ${S}/${PN}/packages/pylab
	fi

	if ! use vtk; then
		rm -rf ${S}/${PN}/packages/vtk
	fi

	if ! use imagemagick; then
		rm -rf ${S}/${PN}/packages/ImageMagick
	fi

	insinto $(python_get_sitedir)
	doins -r ${S}/${PN}

	# Install optional packages
	insinto $(python_get_sitedir)/${PN}/packages

	if use itk; then
		doins -r ${S}/packages/itk
	fi

	if use scipy; then
		doins -r ${S}/packages/NumSciPy
		doins -r ${S}/packages/SciPy
	fi

	exeinto /usr/bin
	doexe ${FILESDIR}/${PN}

    # Install documentation
	dodoc ${S}/doc/*
	if use doc; then
		dodoc ${DISTDIR}/vistrails-usersguide-${USERGUIDE_VERSION}.pdf || die
	fi

    # Install data for examples
    if use examples; then
        insinto /usr/share/${P}/examples
        doins -r ${S}/examples/*
        doins -r ${WORKDIR}/data
    fi
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
