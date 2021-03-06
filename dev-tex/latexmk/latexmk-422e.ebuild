# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latexmk/latexmk-422e.ebuild,v 1.3 2011/02/27 15:52:54 armin76 Exp $

inherit bash-completion

DESCRIPTION="Perl script for automatically building LaTeX documents."
HOMEPAGE="http://www.phys.psu.edu/~collins/software/latexmk/"
SRC_URI="http://www.phys.psu.edu/~collins/software/latexmk/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND="virtual/latex-base
	dev-lang/perl"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_install() {
	cd "${WORKDIR}"
	newbin latexmk.pl latexmk || die
	dodoc CHANGES README latexmk.pdf latexmk.ps latexmk.txt || die
	doman latexmk.1 || die
	insinto /usr/share/doc/${PF}
	doins -r example_rcfiles extra-scripts || die
	dobashcompletion "${FILESDIR}"/completion.bash-2 ${PN}
}
