EAPI="2"

NEED_PYTHON="2.5"

inherit distutils

DESCRIPTION="Classes and command-line utilities for interacting with BibTeX
style databases."
HOMEPAGE="http://code.google.com/p/${PN}/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-python/simpleparse"
DEPEND=""

src_install() {
	DOCS="README.txt"
	distutils_src_install

	if use examples; then
		cd examples
		docinto examples
		for file in *; do
			dodoc "$file"
		done
	fi
	cd ${S}
}

