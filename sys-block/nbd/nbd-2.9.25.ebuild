# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-2.9.25.ebuild,v 1.2 2011/11/29 20:18:54 vapier Exp $

EAPI="4"

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="zlib"

RDEPEND=">=dev-libs/glib-2.0
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--enable-lfs \
		--enable-syslog
}

src_compile() {
	default
	use zlib && emake -C gznbd
}

src_install() {
	default
	use zlib && dobin gznbd/gznbd
}
