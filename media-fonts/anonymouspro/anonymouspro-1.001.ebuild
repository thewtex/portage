inherit font

MY_PN="AnonymousPro"

DESCRIPTION="A family of four fixed-width fonts designed especially with coding in mind."
HOMEPAGE="http://www.ms-studio.com/FontSales/anonymouspro.html"
SRC_URI="http://www.ms-studio.com/FontSales/${MY_PN}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/${MY_PN}"

# Only installs fonts.
RESTRICT="strip binchecks"
