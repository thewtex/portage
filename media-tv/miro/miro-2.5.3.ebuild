# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/vcsroot/gentoo-x86/media-video/miro

EAPI="2"

inherit distutils eutils fdo-mime flag-o-matic python

DESCRIPTION="Open source video player"
HOMEPAGE="http://www.getmiro.com/"
SRC_URI="http://ftp.osuosl.org/pub/pculture.org/miro/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gstreamer libnotify xine"

RDEPEND=">=dev-python/pycairo-1.8
	>=dev-python/pygtk-2.10
	>=net-libs/rb_libtorrent-0.14[python]
	>=net-libs/xulrunner-1.8
	|| ( >=dev-lang/python-2.5[sqlite] >=dev-python/pysqlite-2.3.5 )
	>=dev-lang/python-2.5[ssl]
	>=dev-python/pygobject-2.0
	>=dev-python/pyrex-0.9.6.4
	dev-libs/boost
	dev-python/dbus-python
	>=dev-python/gtkmozembed-python-2.19.1-r11
	dev-python/gconf-python
	dev-python/gnome-vfs-python
	x11-base/xorg-server
	media-gfx/imagemagick
	libnotify? ( dev-python/notify-python dev-libs/poppler-glib )
	gstreamer? ( >=media-libs/gstreamer-0.10 dev-python/gst-python media-plugins/gst-plugins-meta media-video/ffmpeg media-plugins/gst-plugins-wavpack )
	xine? ( media-libs/xine-lib[aac] )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}/${P}/platform/gtk-x11"

pkg_setup() {

	ewarn
	ebeep 5
	ewarn "It is important to note that Miro needs a backend for video playback"
	ewarn "The gstreamer or xine USE flag must be selected for this package to work"
	einfo "Both may be selected at the same time"

	if ! use gstreamer && ! use xine ; then
		einfo
		elog "You did not select the gstreamer or xine use flag."
		elog "Miro will NOT be built."
		einfo
		die "You did not select the gstreamer or xine use flag."
	fi
}

src_compile() {
	filter-ldflags -Wl,--as-needed
	distutils_src_compile
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	einfo
	einfo "To switch between gstreamer and xine playback, open 'video' in the top menu."
	einfo "Than go into 'options,' select 'playback,' and choose gstreamer or xine."
	einfo "Miro must be restarted for a change in playback option to take effect."
}
