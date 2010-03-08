inherit distutils

DESCRIPTION="A ReStructured Text based tool for preparing presentations."
HOMEPAGE="http://pypi.python.org/pypi/rst2beamer/"
SRC_URI="http://pypi.python.org/packages/source/r/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND="app-text/texlive
>=dev-python/docutils-0.6
dev-tex/latex-beamer"

src_install(){
	distutils_src_install

	if use doc; then
		cd ${S}/docs || die "could not change to docs dir"
		# exclude the hidden files
		for file in $(find . -maxdepth 1 -type f \( ! -regex '.*/\..*' \) ); do
			dodoc "$file"
		done
	fi

	if use examples; then
		cd ${S}/docs/examples || die "could not change to examples dir"
		docinto examples
		for file in $(find . -type f \( ! -regex '.*/\..*' \) ); do
			dodoc "$file"
		done
	fi
}
