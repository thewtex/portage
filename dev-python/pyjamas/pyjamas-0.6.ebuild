# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /usr/portage/dev-python/pyjamas/pyjamas-0.6.ebuild $

EAPI=3

inherit distutils

DESCRIPTION="Stand-alone python to javascript compiler"
HOMEPAGE="http://pyjs.org"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd ${S}
	python bootstrap.py /usr/share/pyjamas
	python run_bootstrap_first_then_setup.py build
	sed -i -e's/..\/..\/bin\///' examples/*/build.sh
}

src_install() {
	python run_bootstrap_first_then_setup.py install --root=${D}
	dobin bin/*
	dodoc CHANGELOG
	doman debian/pyjsbuild.1
}
