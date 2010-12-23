# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit distutils

DESCRIPTION="Plugin providing fast loading of revision control data into Bazaar"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI="https://github.com/downloads/tarsius/tarsius-overlay/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-vcs/bzr
	dev-vcs/mercurial
	dev-vcs/subversion"
