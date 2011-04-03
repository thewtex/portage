# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit git

GH_PN="${PN}-ng"

: ${EGIT_REPO_URI:="https://github.com/termie/${GH_PN}.git"}

DESCRIPTION="Bi-directional git to bzr bridge"
HOMEPAGE="http://github.com/termie/${GH_PN}"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-lang/python
	dev-python/python-fastimport
	dev-vcs/bzr
	dev-vcs/bzr-fastimport
	dev-vcs/git"

src_install() {
	dobin git-bzr
	dodoc README.rst
}
