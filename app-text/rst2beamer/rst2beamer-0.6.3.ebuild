inherit distutils

DESCRIPTION="A ReStructured Text based tool for preparing presentations."
HOMEPAGE="http://www.agapow.net/software/${PN}"
SRC_URI="http://www.agapow.net/software/${PN}/${PV}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="app-text/texlive
>=dev-python/docutils-0.6"

src_install(){
	distutils_src_install

	if use doc; then
		cd docs || die "could not change to docs dir"
		# exclude the hidden files
		for file in $(find . -maxdepth 1 -type f \( ! -regex '.*/\..*' \) ); do
			dodoc "$file"
		done
		docinto examples
		cd examples
		for file in $(find . -type f \( ! -regex '.*/\..*' \) ); do
			dodoc "$file"
		done
	fi
}
