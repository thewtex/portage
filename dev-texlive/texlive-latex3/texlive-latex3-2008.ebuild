# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latex3/texlive-latex3-2008.ebuild,v 1.1 2008/09/09 16:46:27 aballier Exp $

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-latex
!=dev-texlive/texlive-latexextra-2007*
"
TEXLIVE_MODULE_CONTENTS="expl3 xpackages collection-latex3
"
TEXLIVE_MODULE_DOC_CONTENTS="expl3.doc xpackages.doc "
TEXLIVE_MODULE_SRC_CONTENTS="expl3.source xpackages.source "
inherit texlive-module
DESCRIPTION="TeXLive LaTeX3 packages"

LICENSE="GPL-2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""