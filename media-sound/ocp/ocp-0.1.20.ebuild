EAPI="1"
inherit flag-o-matic
DESCRIPTION="A console module player"
HOMEPAGE="http://stian.cubic.org/"
SRC_URI="http://stian.cubic.org/ocp/${P}.tar.bz2 \
         ftp://ftp.cubic.org/pub/player/gfx/opencp25image1.zip \
         ftp://ftp.cubic.org/pub/player/gfx/opencp25ani1.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86_64"

IUSE="debug X adplug sidplay alsa flac sdl"
RDEPEND="media-libs/libmad
    media-libs/libogg
    media-libs/libvorbis
    sidplay? ( media-libs/libsidplay:1 )
	X? (
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/libX11
		x11-libs/libXpm
	)
	alsa? ( media-libs/alsa-lib )
	adplug? ( media-libs/adplug )
	flac? ( media-libs/flac )
	sdl? ( media-libs/libsdl )
	media-sound/timidity-eawpatches
    "
DEPEND="$RDEPEND
	sdl? ( dev-util/desktop-file-utils )
	X? ( dev-util/desktop-file-utils )
	sys-apps/texinfo
	app-arch/unzip
"

src_compile() {
	econf --exec-prefix=/usr $(use_with debug) $(use_with adplug) $(use_with X x11) $(use_with sidplay) $(use_with alsa) $(use_with flac) $(use_with sdl) || die
	emake -j 1|| die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die
	cp ../CP* /${D}/usr/share/${P}/data
}
