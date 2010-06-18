EAPI="2"

inherit distutils

DESCRIPTION="Pytrainer is a tool to log all your sport excursions."
HOMEPAGE="http://pytrainer.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/pytrainer/PyTrainer%201.7.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	>=dev-db/sqlite-3.6.20
	>=dev-lang/python-2.6.2
	>=dev-libs/libxml2-2.7.6[python]
	>=dev-libs/libxslt-1.1.26[python]
	>=dev-util/glade-2
	dev-python/gtkmozembed-python
	>=dev-python/python-dateutil-1.4.1
	>=dev-python/matplotlib-0.98.5.2
	>=dev-python/pygtk-2.4
	dev-python/soappy
	>=net-libs/xulrunner-1.9.1.8"

DEPEND="${RDEPEND}"


src_install() {
	distutils_src_install
}
