EAPI="2"

ESVN_REPO_URI="http://bibstuff.googlecode.com/svn/trunk/"

NEED_PYTHON="2.5"

inherit distutils subversion

DESCRIPTION="Classes and command-line utilities for interacting with BibTeX
style databases."
HOMEPAGE="http://www.pricklysoft.org/software/bibstuff.html"

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

