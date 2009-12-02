EAPI="2"

DESCRIPTION="CAJUN is a C++ API for the JSON data interchange format with an
emphasis on an intuitive, concise interface."
HOMEPAGE="http://cajun-jsonapi.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/cajun-jsonapi/cajun-jsonapi/${PV}/${PN}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_install()
{
	insinto /usr/include
	doins -r json

	dodoc Readme.txt ReleaseNotes.txt test.cpp Makefile
}
