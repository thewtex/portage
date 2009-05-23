# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/nerdcommenter/nerdcommenter-2.1.18.ebuild,v 1.1 2008/09/21 12:07:34 hawking Exp $

VIM_PLUGIN_VIM_VERSION=7.0
inherit vim-plugin

DESCRIPTION="vim plugin: easy commenting of code for many filetypes."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1218"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="NERD_commenter"

# the .php doesn't resolve to the correct filename
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=10318"
DEPEND="${DEPEND} app-arch/unzip"
RESTRICT="mirror"
S="${WORKDIR}"

src_unpack(){
	unzip "${DISTDIR}/${A}" || die "unpack failed"
}
