# Copyright 1999-2011 Funtoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="oblogout"

inherit versionator distutils

MY_PV=$(get_version_component_range 1-2)
S=${WORKDIR}/${PN}

DESCRIPTION="OBLogout is a expandable, configurable, and theme-able logout script designed to be used in a Openbox desktop environment."
HOMEPAGE="https://launchpad.net/oblogout"
SRC_URI="http://launchpad.net/oblogout/${MY_PV}/${PV}/+download/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/python-distutils-extra
dev-python/imaging
dev-python/dbus-python
sys-power/upower
x11-libs/cairo
dev-python/pygtk
sys-auth/consolekit"

RDEPEND=""

src_prepare(){
	epatch "${FILESDIR}/${P}_archlinux.patch" || die
}

src_install(){
	distutils_src_install
	insinto /etc
	doins ${FILESDIR}/oblogout.conf || die
}

