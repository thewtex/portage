# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/gecko-mediaplayer/gecko-mediaplayer-1.0.5_beta1_p20111203.ebuild,v 1.1 2011/12/02 22:46:20 ssuominen Exp $

EAPI=4
inherit autotools eutils multilib nsplugins

MY_P=${PN}-${PV/_beta/b}

DESCRIPTION="A browser plugin that uses GNOME MPlayer"
HOMEPAGE="http://code.google.com/p/gecko-mediaplayer/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz
	http://dev.gentoo.org/~ssuominen/${PN}-gconf-2.m4.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86" # ~ppc64 missing in npapi-sdk
IUSE="+curl"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.28:2
	dev-libs/nspr
	>=media-libs/gmtk-1.0.5_beta
	>=media-video/gnome-mplayer-1.0.5_beta[dbus]
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=net-misc/npapi-sdk-0.27
	sys-devel/gettext"

DOCS="ChangeLog DOCS/tech/*.txt"

src_prepare() {
	AT_M4DIR=${WORKDIR} eautoreconf
}

src_configure() {
	econf \
		--with-plugin-dir=/usr/$(get_libdir)/${PLUGINS_DIR} \
		$(use_with curl libcurl)
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/doc/${PN}
}
