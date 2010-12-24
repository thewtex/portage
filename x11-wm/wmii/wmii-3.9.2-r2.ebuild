# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit flag-o-matic multilib toolchain-funcs

MY_P=wmii+ixp-${PV}

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://${PN}.suckless.org/"
SRC_URI="http://dl.suckless.org/${PN}/${MY_P}.tbz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"
IUSE="doc plan9 python ruby"

COMMON_DEPEND="
	x11-libs/libXft
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXinerama
	>=media-libs/freetype-2"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xmessage
	x11-apps/xsetroot
	media-fonts/font-misc-misc
	plan9? ( dev-util/plan9port )
	ruby? ( dev-lang/ruby )"
DEPEND="${COMMON_DEPEND}
	app-text/txt2tags
	dev-util/pkgconfig"

DOCS="NEWS NOTES README TODO"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	mywmiiconf=(
		"PREFIX=/usr"
		"DOC=/usr/share/doc/${PF}"
		"ETC=/etc"
		"LIBDIR=/usr/$(get_libdir)"
		"CC=$(tc-getCC) -c"
		"LD=$(tc-getCC)"
		"AR=$(tc-getAR) crs"
		"DESTDIR=${D}"
		)
}

src_prepare() {
	alt=alternative_wmiircs/Makefile

	if use python || use plan9 || use ruby
	then
		use python || { sed -i -e "/^DIRS =	python/s|python||" $alt || die; }
		use plan9  || { sed -i -e "/^\tplan9port/d"            $alt || die; }
		use ruby   || { sed -i -e "/^\truby/d"                 $alt || die; }
	else
		sed -i -e "/^\talternative_wmiircs/d"     Makefile || die
	fi
	use plan9 || { sed -i -e "/^\twmii\.rc/d" cmd/Makefile || die; }
	use doc   || { sed -i -e "/^\tdoc/d"          Makefile || die; }

	sed -i -e "/BINSH \!=/d" mk/hdr.mk || die #335083

	rm -f man/*.1
}

src_compile() {
	append-flags -I/usr/include/freetype2
	emake "${mywmiiconf[@]}" || die
}

src_install() {
	emake "${mywmiiconf[@]}" install || die
	dodoc ${DOCS} || die

	echo "until wmii; do :; done" > "${T}"/wmii
	exeinto /etc/X11/Sessions
	doexe "${T}"/wmii || die

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die
}
