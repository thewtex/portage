EAPI="2"

inherit qt4

DESCRIPTION="KLatexFormula is a program to easily get an image from a LaTeX formula"
HOMEPAGE="http://klatexformula.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui
	virtual/latex-base"

RDEPEND="${DEPEND}
	virtual/ghostscript"

src_configure() {
	eqmake4
}

src_build() {
	emake || die
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc AUTHORS README
}
