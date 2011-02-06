# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit git

: ${EGIT_REPO_URI:="git://github.com/purcell/${PN}.git"}

DESCRIPTION="Make git mirrors of darcs repositories"
HOMEPAGE="http://github.com/purcell/${PN}"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/ruby
	dev-vcs/git"
RDEPEND="${DEPEND}
	dev-vcs/darcs"

src_install() {
	dobin darcs-to-git
}
