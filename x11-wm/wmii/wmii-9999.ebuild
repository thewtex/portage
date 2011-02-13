# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit flag-o-matic multilib toolchain-funcs mercurial

: ${EHG_REPO_URI:="http://hg.suckless.org/${PN}"}

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://${PN}.suckless.org"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc plan9 python ruby"

COMMON_DEPEND="
	>=media-libs/freetype-2
	=sys-libs/libixp-9999
	x11-libs/libXft
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXinerama"
RDEPEND="${COMMON_DEPEND}
	media-fonts/font-misc-misc
	x11-apps/xmessage
	plan9? ( dev-util/plan9port )
	ruby? ( dev-lang/ruby )"
DEPEND="${COMMON_DEPEND}
	app-text/txt2tags
	dev-util/pkgconfig"

DOCS="FAQ NEWS README TODO"

S="${WORKDIR}/${PN}"

pkg_setup() {
	mywmiiconf=(
		"PREFIX=/usr"
		"DOC=/usr/share/doc/${PF}"
		"ETC=/etc"
		"LIBDIR=/usr/$(get_libdir)"
		"CC=$(tc-getCC) -c"
		"LD=$(tc-getCC)"
		"AR=$(tc-getAR) crs"
		"DESTDIR=${D}")
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PV}-wmiirc-fixes.patch"

	rm -f man/*.1

	local alt=alternative_wmiircs/Makefile

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

	sed -i -e "/^CONFDIR =/s|wmii-hg|wmii|" mk/wmii.mk || die
}

src_compile() {
	append-flags -I/usr/include/freetype2
	emake "${mywmiiconf[@]}" || die
}

src_install() {
	emake "${mywmiiconf[@]}" install || die
	dodoc ${DOCS} || die

	cat > "${T}"/wmii << "EOF"
# xsetroot -solid #333333 &
# feh --bg-center /path/to/image &
until wmii; do :; done
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}"/wmii || die

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop || die
}
