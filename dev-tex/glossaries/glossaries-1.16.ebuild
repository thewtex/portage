# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/glossaries/glossaries-1.16.ebuild,v 1.8 2009/02/27 15:42:21 fmccor Exp $

inherit latex-package

DESCRIPTION="Create glossaries and lists of acronyms."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/glossaries.html"
SRC_URI="mirror://gentoo/${P}.zip"

# Taken from :
# ftp://tug.ctan.org/tex-archive/macros/latex/contrib/${PN}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND="dev-lang/perl
	|| ( dev-texlive/texlive-latexrecommended >=dev-tex/xkeyval-2.5f )
	>=dev-texlive/texlive-latexextra-2008
	"
DEPEND="${RDEPEND}
	 app-arch/unzip"

TEXMF="/usr/share/texmf-site"
S=${WORKDIR}/${PN}

src_install() {
	latex-package_src_doinstall styles

	dobin makeglossaries

	dodoc CHANGES README
	insinto "${TEXMF}/tex/latex/${PN}/dict"
	doins *.dict
	if use doc ; then
		latex-package_src_doinstall pdf
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins *.tex
	fi
}
