EAPI="2"

DESCRIPTION="CCSense is the most intelligent development tools for C/C++ using GCC's code analyzers."
HOMEPAGE="http://cx4a.org/software/gccsense/"
SRC_URI="http://cx4a.org/pub/gccsense/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/ruby
	dev-libs/gmp
	dev-libs/mpfr
	dev-ruby/rubygems
	dev-ruby/sqlite3-ruby
	dev-util/gcc-code-assist
	sys-devel/flex"
DEPEND=""

DOCS="README TODO doc/index.txt doc/manual.txt doc/demo.txt"

src_install() {
	exeinto /usr/bin
	doexe ${S}/bin/autopch
	doexe ${S}/bin/gccrec

	insinto /usr/share/vim/vimfiles/plugin
	doins etc/gccsense.vim
	
	# sorry I'm not sure what to do with the etc/gccsense.el
}

