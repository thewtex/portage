# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit eutils java-pkg-2 versionator multilib toolchain-funcs

MY_PN="OpenFOAM"
MY_PV=$(get_version_component_range 1-3 ${PV})
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="OpenFOAM - wmake"
HOMEPAGE="http://www.opencfd.co.uk/openfoam/"
SRC_URI="mirror://sourceforge/foam/${MY_P}.General.gtgz
	http://dev.gentooexperimental.org/~tommy/${P}.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples lam mpich"

RDEPEND="!sci-libs/openfoam
	!sci-libs/openfoam-bin
	net-misc/openssh
	net-misc/mico
	<virtual/jdk-1.5
	|| ( >sci-visualization/paraview-3.0 sci-visualization/opendx )
	!mpich? ( !lam? ( sys-cluster/openmpi ) )
	lam? ( sys-cluster/lam-mpi )
	mpich? ( sys-cluster/mpich2 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! version_is_at_least 4.1 $(gcc-version) ; then
		die "${PN} requires >=sys-devel/gcc-4.1 to compile."
	fi

	if use amd64 ; then
		elog
		elog "In order to use OpenFOAM you should add the following lines to ~/.bashrc :"
		elog 'WM_64="on"'
		elog "source /usr/$(get_libdir)/OpenFOAM/bashrc"
	else
		elog
		elog "In order to use OpenFOAM you should add the following line to ~/.bashrc :"
		elog "source /usr/$(get_libdir)/OpenFOAM/bashrc"
	fi

	elog
	elog "In order to get FoamX running, you have to do the following: "
	elog "mkdir -p ~/.${MY_P}/apps "
	elog "cp -r /usr/$(get_libdir)/${MY_PN}/${MY_P}/.${MY_P}/apps/FoamX ~/.${MY_P}/apps "
	elog

	java-pkg-2_pkg_setup
}

src_unpack() {
	ln -s "${DISTDIR}"/${MY_P}.General.gtgz ${MY_P}.General.tgz
	unpack ./${MY_P}.General.tgz

	cd "${S}"
	epatch "${DISTDIR}"/${P}.patch
	epatch "${FILESDIR}"/${PN}-compile-${PV}.patch
	epatch "${FILESDIR}"/${PN}-paraFoam-${PV}.patch
}

src_compile() {
	use amd64 && export WM_64="on"

	if use lam ; then
		export WM_MPLIB=LAM
	elif use mpich ; then
		export WM_MPLIB=MPICH
	else
		export WM_MPLIB=OPENMPI
	fi

	sed -i -e "s|WM_PROJECT_VERSION=|WM_PROJECT_VERSION=${MY_PV} #|"	\
		-e "s|export WM_PROJECT_INST_DIR=\$HOME/\$WM_PROJECT|# export WM_PROJECT_INST_DIR=\$HOME/\$WM_PROJECT|"	\
		-e "s|#export WM_PROJECT_INST_DIR=/usr/local/\$WM_PROJECT|export WM_PROJECT_INST_DIR=/usr/$(get_libdir)/\$WM_PROJECT|"	\
		-e "s|[^#]export WM_MPLIB=| #export WM_MPLIB=|"	\
		-e "s|#export WM_MPLIB=$|export WM_MPLIB="${WM_MPLIB}"|" \
		-e "s|SOURCE \$WM_PROJECT_DIR/\$FOAM_DOT_DIR/apps|#SOURCE \$WM_PROJECT_DIR/\$FOAM_DOT_DIR/apps|"	\
			"${S}"/.${MY_P}/bashrc

	sed -i -e "s|WM_PROJECT_VERSION |WM_PROJECT_VERSION ${MY_PV} #|"	\
		-e "s|setenv WM_PROJECT_INST_DIR \$HOME/\$WM_PROJECT|# setenv WM_PROJECT_INST_DIR \$HOME/\$WM_PROJECT|"	\
		-e "s|#setenv WM_PROJECT_INST_DIR /usr/local/\$WM_PROJECT|setenv WM_PROJECT_INST_DIR /usr/$(get_libdir)/\$WM_PROJECT|"	\
		-e "s|[^#]setenv WM_MPLIB | #setenv WM_MPLIB |"	\
		-e "s|#setenv WM_MPLIB OPENMPI|setenv WM_MPLIB "${WM_MPLIB}"|" \
		-e "s|SOURCE \$WM_PROJECT_DIR/\$FOAM_DOT_DIR/apps|#SOURCE \$WM_PROJECT_DIR/\$FOAM_DOT_DIR/apps|"	\
			"${S}"/.${MY_P}/cshrc

	sed -i -e "s|FOAM_JOB_DIR=\$WM_PROJECT_INST_DIR/jobControl|FOAM_JOB_DIR=\$HOME/\$WM_PROJECT/jobControl|"	\
		-e "s|WM_COMPILER_DIR=|WM_COMPILER_DIR=/usr # |"	\
		-e 's|JAVA_HOME=|JAVA_HOME=${JAVA_HOME} # |'	\
		-e 's@OPENMPI_VERSION=@OPENMPI_VERSION=`/usr/bin/ompi_info --version ompi full --parsable | grep ompi:version:full | cut -d: -f4-` # @'	\
		-e 's|[^#]export OPENMPI_HOME=|# export OPENMPI_HOME=|'	\
		-e 's|OPENMPI_ARCH_PATH=|OPENMPI_ARCH_PATH=/usr # |'	\
		-e 's@LAM_VERSION=@LAM_VERSION=`/usr/bin/laminfo -version lam full | awk ''{print \$\$2}''` # @'	\
		-e 's|[^#]export LAMHOME=|# export LAMHOME=|'	\
		-e 's|LAM_ARCH_PATH=|LAM_ARCH_PATH=/usr # |'	\
		-e 's|MPICH_VERSION=|MPICH_VERSION=`/usr/bin/mpich2version --version` # |'	\
		-e 's|[^#]export MPICH_PATH=$FOAM_SRC|# export MPICH_PATH=$FOAM_SRC|'	\
		-e 's|MPICH_ARCH_PATH=|MPICH_ARCH_PATH=/usr # |'	\
		-e 's|AddLib $OPENMPI_ARCH_PATH|# AddLib $OPENMPI_ARCH_PATH|'	\
		-e 's|AddPath $OPENMPI_ARCH_PATH|# AddPath $OPENMPI_ARCH_PATH|'	\
		-e 's|AddLib $LAM_ARCH_PATH|# AddLib $LAM_ARCH_PATH|'	\
		-e 's|AddPath $LAM_ARCH_PATH|# AddPath $LAM_ARCH_PATH|'	\
		-e 's|AddLib $MPICH_ARCH_PATH|# AddLib $MPICH_ARCH_PATH|'	\
		-e 's|AddPath $MPICH_ARCH_PATH|# AddPath $MPICH_ARCH_PATH|'	\
		-e 's|$FOAM_LIBBIN/openmpi-$OPENMPI_VERSION|$FOAM_LIBBIN/openmpi|'	\
		-e 's|$FOAM_LIBBIN/lam-$LAM_VERSION|$FOAM_LIBBIN/lam|'	\
		-e 's|$FOAM_LIBBIN/mpich-$MPICH_VERSION|$FOAM_LIBBIN/mpich|'	\
		-e 's|MICO_VERSION=|MICO_VERSION=`/usr/bin/mico-config --version` # |'	\
		-e "s|[^#]export MICO_PATH=|# export MICO_PATH=|"	\
		-e "s|MICO_ARCH_PATH=|MICO_ARCH_PATH=/usr # |"	\
			"${S}"/.bashrc

	sed -i -e "s|FOAM_JOB_DIR \$WM_PROJECT_INST_DIR/jobControl|FOAM_JOB_DIR \$HOME/\$WM_PROJECT/jobControl|"	\
		-e "s|WM_COMPILER_DIR |WM_COMPILER_DIR /usr # |"	\
		-e 's|JAVA_HOME |JAVA_HOME ${JAVA_HOME} # |'	\
		-e 's@OPENMPI_VERSION @OPENMPI_VERSION `/usr/bin/ompi_info --version ompi full --parsable | grep ompi:version:full | cut -d: -f4-` # @'	\
		-e 's|[^#]setenv OPENMPI_HOME|# setenv OPENMPI_HOME|'	\
		-e 's|OPENMPI_ARCH_PATH |OPENMPI_ARCH_PATH /usr # |'	\
		-e 's@LAM_VERSION @LAM_VERSION `/usr/bin/laminfo -version lam full | awk ''{print \$\$2}''` # @'	\
		-e 's|[^#]setenv LAMHOME|# setenv LAMHOME|'	\
		-e 's|LAM_ARCH_PATH |LAM_ARCH_PATH /usr # |'	\
		-e 's|MPICH_VERSION |MPICH_VERSION `/usr/bin/mpich2version --version` # |'	\
		-e 's|[^#]setenv MPICH_PATH $FOAM_SRC|# setenv MPICH_PATH $FOAM_SRC|'	\
		-e 's|MPICH_ARCH_PATH |MPICH_ARCH_PATH /usr # |'	\
		-e 's|AddLib $OPENMPI_ARCH_PATH|# AddLib $OPENMPI_ARCH_PATH|'	\
		-e 's|AddPath $OPENMPI_ARCH_PATH|# AddPath $OPENMPI_ARCH_PATH|'	\
		-e 's|AddLib $LAM_ARCH_PATH|# AddLib $LAM_ARCH_PATH|'	\
		-e 's|AddPath $LAM_ARCH_PATH|# AddPath $LAM_ARCH_PATH|'	\
		-e 's|AddLib $MPICH_ARCH_PATH|# AddLib $MPICH_ARCH_PATH|'	\
		-e 's|AddPath $MPICH_ARCH_PATH|# AddPath $MPICH_ARCH_PATH|'	\
		-e 's|$FOAM_LIBBIN/openmpi-$OPENMPI_VERSION|$FOAM_LIBBIN/openmpi|'	\
		-e 's|$FOAM_LIBBIN/lam-$LAM_VERSION|$FOAM_LIBBIN/lam|'	\
		-e 's|$FOAM_LIBBIN/mpich-$MPICH_VERSION|$FOAM_LIBBIN/mpich|'	\
		-e 's|MICO_VERSION |MICO_VERSION `/usr/bin/mico-config --version` # |'	\
		-e "s|[^#]setenv MICO_PATH |# setenv MICO_PATH |"	\
		-e "s|MICO_ARCH_PATH |MICO_ARCH_PATH /usr # |"	\
			"${S}"/.cshrc

	cp "${S}"/.${MY_P}/bashrc "${S}"/.${MY_P}/bashrc.bak || "cannot copy bashrc"

	sed -i -e "s|WM_PROJECT_INST_DIR=/usr/$(get_libdir)/\$WM_PROJECT|WM_PROJECT_INST_DIR="${WORKDIR}"|"		\
		-e "s|WM_PROJECT_DIR=\$WM_PROJECT_INST_DIR/\$WM_PROJECT-\$WM_PROJECT_VERSION|WM_PROJECT_DIR="${S}"|"	\
		"${S}"/.${MY_P}/bashrc.bak	\
		|| die "could not replace source options"

	source "${S}"/.${MY_P}/bashrc.bak

	find "${S}"/wmake -name dirToString | xargs rm -rf
	find "${S}"/wmake -name wmkdep | xargs rm -rf

	cd "${S}"/wmake
	./makeWmake || die "could not build wmake"

	rm "${S}"/bin/paraFoam.pvs
	rm "${S}"/.${MY_P}/bashrc.bak

	sed -i -e "s|/\$WM_OPTIONS||" "${S}"/.bashrc || die "could not delete \$WM_OPTIONS in .bashrc"
	sed -i -e "s|/\$WM_OPTIONS||" "${S}"/.cshrc || die "could not delete \$WM_OPTIONS in .cshrc"
}

src_test() {
	cd "${S}"/bin
	./foamInstallationTest
}

src_install() {
	insinto /usr/$(get_libdir)/"${MY_PN}"/${MY_P}
	doins -r .bashrc .cshrc .${MY_P}

	use examples && doins -r tutorials

	insopts -m0755
	doins -r bin

	insinto /usr/$(get_libdir)/${MY_PN}/${MY_P}/wmake
	doins -r wmake/*

	insopts -m0644
	insinto /usr/share/${MY_PN}/${MY_P}/doc
	doins -r README doc/Guides-a4 doc/Guides-usletter

	dosym /usr/$(get_libdir)/${MY_PN}/${MY_P}/.${MY_P}/bashrc /usr/$(get_libdir)/${MY_PN}/bashrc
	dosym /usr/$(get_libdir)/${MY_PN}/${MY_P}/.${MY_P}/cshrc /usr/$(get_libdir)/${MY_PN}/cshrc
}
