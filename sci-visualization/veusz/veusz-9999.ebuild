# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.4.ebuild,v 1.1 2009/06/05 17:13:14 grozin Exp $

ESVN_REPO_URI="svn://svn.gna.org/svn/veusz/trunk"

EAPI=2
inherit eutils distutils fdo-mime subversion

DESCRIPTION="Qt based scientific plotting package with good Postscript output"
HOMEPAGE="http://home.gna.org/veusz/"
#SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc examples fits"
SLOT="0"
KEYWORDS=""
LICENSE="GPL-2"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	dev-python/PyQt4[X,svg]
	doc? ( app-text/docbook-sgml-utils )
	fits? ( dev-python/pyfits )"

src_compile()
{
	base_src_compile

	if use doc; then
		cd Documents
		./generate_manual.sh || die "generating manuals failed"
	fi
}

src_install() {
	distutils_src_install
	dodoc Interface.txt
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die "examples install failed"
	fi
	if use doc; then
		cd Documents
		insinto /usr/share/doc/${PF}
		doins manual.pdf
		insinto /usr/share/doc/${PF}/html
		doins -r manual.html manimages \
			|| die "doc install failed"
	fi
	newicon "${S}"/windows/icons/veusz_48.png veusz.png
	domenu "${FILESDIR}"/veusz.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/veusz.xml
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
}
