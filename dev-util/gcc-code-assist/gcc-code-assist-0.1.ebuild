GCC_VERSION="4.4.4"

EAPI="2"

DESCRIPTION="gcc-code-assist is a custom GCC that has functions such as code
completion"
HOMEPAGE="http://cx4a.org/software/gccsense/"
SRC_URI="http://cx4a.org/pub/gccsense/${P}-${GCC_VERSION}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# For safety we block the specific version the branch is based off of.
DEPEND=">=sys-devel/gcc-4.4
  !~sys-devel/gcc-${GCC_VERSION}"
RDEPEND=""

S="${WORKDIR}/${P}-${GCC_VERSION}"

src_configure() {
	econf --program-suffix=-code-assist --disable-bootstrap \
	--enable-languages=c,c++ --disable-multilib
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

