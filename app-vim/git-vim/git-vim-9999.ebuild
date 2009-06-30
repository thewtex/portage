
EGIT_REPO_URI="git://github.com/motemen/git-vim.git"
VIM_PLUGIN_VIM_VERSION=7.0
inherit git vim-plugin 

DESCRIPTION="vim plugin: quickly switch between buffers."
HOMEPAGE="http://github.com/motemen/git-vim/tree/master"
LICENSE=""
KEYWORDS=""
IUSE=""
SRC_URI=""

RESTRICT="mirror"

src_unpack() {
	git_src_unpack
	cd "${S}"
	rm -rf .git
}
