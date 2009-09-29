EAPI="2"

NEED_PYTHON="2.5"

inherit distutils eutils

DESCRIPTION="Classes and command-line utilities for interacting with BibTeX
style databases."
HOMEPAGE="http://www.pricklysoft.org/software/bibstuff.html"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-python/simpleparse"
DEPEND=""

src_prepare(){
	epatch ${FILESDIR}/0001-fix-variable-name-in-bibstyles-example_numbered.py.patch || \
		die "patch failed"
	epatch ${FILESDIR}/0002-fix-assert-error-syntax-in-bibstyles-shared.py.patch || \
		die "patch failed"
}

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

