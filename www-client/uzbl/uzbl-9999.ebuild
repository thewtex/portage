EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"

inherit git

EAPI="2"

DESCRIPTION="A keyboard controlled (modal vim-like bindings, or with modifier keys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org/"
#SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=net-libs/libsoup-2.24
>=net-libs/webkit-gtk-1.1.4
x11-libs/gtk+:2"
DEPEND="dev-util/pkgconfig
${RDEPEND}"

src_install(){
	emake DESTDIR="${D}" install || die "make install failed"
}
