EAPI="2"

inherit versionator python

MY_PV="${PV/_p/-rev}"

DESCRIPTION="VisTrails is a scientific workflow and provenance management system that provides support for data exploration and visualization."
HOMEPAGE="http://vistrails.org/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/v$(get_version_component_range 1-3)/${PN}-src-${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="itk +imagemagick +matplotlib scipy +vtk"

DEPEND="${DEPEND}"
RDEPEND="dev-python/PyQt4
  dev-python/numpy
  matplotlib? ( dev-python/matplotlib )
  imagemagick? ( media-gfx/imagemagick )
  itk? ( sci-libs/wrapitk )
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
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
