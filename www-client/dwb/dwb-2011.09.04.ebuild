# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Webkit-browser similar to vimprobable written in C"
HOMEPAGE="http://portix.bitbucket.org/dwb/"
SRC_URI="https://bitbucket.org/portix/dwb/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		net-libs/webkit-gtk
		x11-libs/gtk+"

src_install() {
	emake DESTDIR="${D}" install || die
}
