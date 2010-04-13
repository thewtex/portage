EAPI="2"

VIM_PLUGIN_VIM_VERSION=7.1
inherit vim-plugin

MY_P="${PN}_${PV}"

DESCRIPTION="Run interactive commands inside a Vim buffer"
HOMEPAGE="http://code.google.com/p/conque/"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
IUSE="python"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz
	python? ( http://conque.googlecode.com/files/conque_term_pylab.vim )"

RDEPEND="${RDEPEND}
  >=dev-lang/python-2.3"

VIM_PLUGIN_HELPTEXT=\
"Type :ConqueTerm <command> to run your command in vim, for example:

:ConqueTerm bash
:ConqueTerm mysql -h localhost -u joe -p sock_collection
:ConqueTerm ipython
To open Conque in a new horizontal or vertical buffer use:

:ConqueTermSplit <command>
:ConqueTermVSplit <command>
All text typed in insert mode will be sent to your shell. Use the <F9> key to send a visual selection from any buffer to the shell.

For more help type :help ConqueTerm"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default_src_unpack

	use python && cp "${DISTDIR}/conque_term_pylab.vim" "${S}/plugin" || die "could not move conque_term_pylab"
}

src_install() {
	rm ${S}/conque_term.vba

	vim-plugin_src_install
}
