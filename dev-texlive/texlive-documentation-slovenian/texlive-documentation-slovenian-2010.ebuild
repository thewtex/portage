# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-slovenian/texlive-documentation-slovenian-2010.ebuild,v 1.7 2011/10/04 18:15:29 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-slovenian collection-documentation-slovenian
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-slovenian.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Slovenian documentation"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2010
"
RDEPEND="${DEPEND} "
