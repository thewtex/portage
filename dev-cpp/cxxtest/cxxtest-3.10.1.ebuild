EAPI="2"

DESCRIPTION="CxxTest is a JUnit/CppUnit/xUnit-like framework for C/C++."
HOMEPAGE="http://cxxtest.tigris.org/"
SRC_URI="http://${PN}.tigris.org/files/documents/6421/43281/${P}.tar.gz
  doc? ( http://${PN}.tigris.org/files/documents/6421/43284/${PN}-guide-${PV}.pdf )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

DEPEND=""
RDEPEND="|| ( dev-lang/perl virtual/python )"

DOCS="COPYING README TODO Versions"

S="${WORKDIR}/${PN}"

src_install() {
	dodoc ${DOCS}

	insinto /usr/include/${PN}
	doins ${PN}/*

	exeinto /usr/bin
	doexe cxxtestgen.pl cxxtestgen.py

	if use doc; then
		dohtml docs/*
		dodoc "${DISTDIR}/${PN}-guide-${PV}.pdf"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r sample/*
	fi
}
