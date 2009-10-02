EAPI="2"

ESVN_REPO_URI="http://svn.berlios.de/svnroot/repos/docutils/trunk/sandbox"

inherit python multilib subversion

DESCRIPTION="Hacks for using LaTeX formula in ReStructuredText documents."
HOMEPAGE="http://docutils.sourceforge.net/sandbox/cben/rolehack/"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="${DEPEND}
  app-accessibility/speech-tools
  app-text/texlive
  virtual/ghostscript
  media-libs/netpbm"

src_install() {
	python_version
	insinto $(python_get_sitedir)
	doins ${S}/cben/rolehack/rolehack.py 
	exeinto /usr/bin
	doexe ${S}/cben/rolehack/mathhack.py
	doexe ${S}/cben/rolehack/imgmathhack.py
	dodoc ${S}/cben/rolehack/README.txt
}

pkg_postinst() {
	python_mod_compile $(python_get_sitedir)/rolehack.py
}

pkg_postrm() {
	python_mod_cleanup
}
