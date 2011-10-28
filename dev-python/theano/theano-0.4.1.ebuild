# Copyright 1999-2011 Funtoo Technologies 
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND=2:2.4
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS=1

inherit distutils eutils python

MY_PN="Theano"
MY_P="${MY_PN}-${PVR}"

DESCRIPTION="An optimizing compiler for evaluating mathematical expressions on CPUs and GPUs"
HOMEPAGE="http://deeplearning.net/software/theano"
SRC_URI="http://pypi.python.org/packages/source/T/${MY_PN}/${MY_P}.tar.gz#md5=68a66dc7e18ad3bae20e9ed8a89f97f4 -> ${MY_P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="virtual/blas
	virtual/lapack
	virtual/cblas
	sci-libs/scipy
	>=dev-python/numpy-1.3.0"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
