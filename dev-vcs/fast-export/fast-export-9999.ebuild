# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit git

: ${EGIT_REPO_URI:="git://repo.or.cz/fast-export.git"}

DESCRIPTION="Programs to feed git-fast-import"
HOMEPAGE="http://repo.or.cz/w/fast-export.git"
SRC_URI=""

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="subversion"

RDEPEND="dev-vcs/git
	dev-vcs/mercurial
	subversion? ( dev-vcs/subversion )"

src_compile() { :; }

src_install() {
	dobin hg*.py hg*.sh
	use subversion && dobin svn-fast-export.py
	dodoc hg-fast-export.txt
}
