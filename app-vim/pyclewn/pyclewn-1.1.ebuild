inherit distutils

DESCRIPTION="Pyclewn allows using vim as a front end to a debugger."
HOMEPAGE="http://pyclewn.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/pyclewn/pyclewn/${P}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE=""
SLOT="0"

RDEPEND="dev-lang/python
  app-editors/gvim[console-netbeans,netbeans]
  sys-devel/gdb"
DEPEND="${DEPEND}"
