# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/chktex/chktex-1.6.4.ebuild,v 1.11 2009/03/18 19:12:09 armin76 Exp $

DESCRIPTION="Checks latex source for common mistakes"
HOMEPAGE="http://baruch.ev-en.org/proj/chktex/"
SRC_URI="http://baruch.ev-en.org/proj/chktex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug doc"

DEPEND="virtual/latex-base
	dev-lang/perl
	sys-apps/groff
	doc? ( dev-tex/latex2html )"

src_compile() {
	econf `use_enable debug debug-info` || die
	emake || die
	if use doc ; then
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc NEWS
	if use doc ; then
		dohtml HTML/ChkTeX/*
		dodoc HTML/ChkTeX.tex
	fi
	doman *.1
}
