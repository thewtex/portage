# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libsyncml/libsyncml-0.5.2-r1.ebuild,v 1.2 2009/11/15 21:14:28 eva Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Implementation of the SyncML protocol"
HOMEPAGE="http://libsyncml.opensync.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="bluetooth debug doc http +obex"

# libsoup:2.2 is forced off to avoid automagic
RDEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libwbxml-0.9.2
	dev-libs/libxml2
	http? ( net-libs/libsoup:2.4 )
	obex? ( >=dev-libs/openobex-1.1 )
	bluetooth? ( net-wireless/bluez
		>=dev-libs/openobex-1.1[bluetooth] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

# Some of the tests are broken
RESTRICT="test"

pkg_setup() {
	if ! use obex && ! use http; then
		eerror "${CATEGORY}/${P} without support for obex nor http is unusable."
		eerror "Please enable \"obex\" or/and \"http\" USE flags."
		die "Please enable \"obex\" or/and \"http\" USE flags."
	fi

	if use bluetooth && ! use obex; then
		eerror "You are trying to build ${CATEGORY}/${P} with the \"bluetooth\""
		eerror "USE flag, but you didn't enable the \"obex\" flag, which is"
		eerror "needed for bluetooth support."
		eerror "Please enable \"obex\" USE flag."
		die "Please enable \"obex\" USE flag."
	fi
}

src_configure() {
	local mycmakeargs="
		-DHAVE_LIBSOUP22=OFF
		$(cmake-utils_use_enable http HTTP)
		$(cmake-utils_use_enable obex OBEX)
		$(cmake-utils_use_enable bluetooth BLUETOOTH)
		$(cmake-utils_use_enable debug TRACE)"

	cmake-utils_src_configure
}
