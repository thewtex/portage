# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# adapted by thewtex 2008 July 31

VIM_PLUGIN_VIM_VERSION=7.0
inherit vim-plugin

DESCRIPTION="vim plugin: quickly switch between buffers."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=42"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=9524"
DEPEND="${DEPEND} app-arch/unzip"
RESTRICT="mirror"
S="${WORKDIR}"

src_unpack(){
	unzip "${DISTDIR}/${A}" || die "unpack failed"
}
