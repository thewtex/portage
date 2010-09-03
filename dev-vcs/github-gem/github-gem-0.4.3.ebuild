USE_RUBY="ruby18"
MY_P="github-${PV}.gem"
inherit gems

DESCRIPTION="The official github command line helper for simplifying your GitHub experience."
HOMEPAGE="http://github.com"
SRC_URI="http://rubygems.org/downloads/github-${PV}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/highline-1.5.1
>=dev-ruby/json-1.2.0
>=dev-ruby/rubygems-1.3.0
>=dev-ruby/text-format-1.0.0"
RDEPEND="${DEPEND}"

