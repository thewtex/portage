inherit distutils

DESCRIPTION="A ReStructured Text based tool for preparing presentations."
HOMEPAGE="http://www.agapow.net/software/${PN}"
SRC_URI="http://www.agapow.net/software/${PN}/${PV}/${P}.tar.gz"

LICENSE=""
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
