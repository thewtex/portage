# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-configtool/fcitx-configtool-0.3.1.ebuild,v 1.1 2011/11/02 06:58:29 qiaomuf Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A gtk GUI to edit fcitx settings"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	=app-i18n/fcitx-4.1.2
	dev-libs/libunique:1
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"
