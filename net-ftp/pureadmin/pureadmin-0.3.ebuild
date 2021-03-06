# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pureadmin/pureadmin-0.3.ebuild,v 1.5 2011/03/28 17:01:06 angelos Exp $

EAPI=3
inherit eutils

DESCRIPTION="PureAdmin is a GUI tool used to make the management of Pure-FTPd a little easier."
HOMEPAGE="http://purify.sourceforge.net/"
SRC_URI="mirror://sourceforge/purify/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc"

RDEPEND="gnome-base/libglade:2.0
		sys-libs/zlib
		virtual/fam
		x11-libs/gtk+:2"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_configure() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Move the docs to the correct location, if we want the docs
	if use doc ; then
		dodoc "${D}/usr/share/doc/pureadmin/*.txt"
	fi
	rm -Rf "${D}/usr/share/doc/pureadmin"

	make_desktop_entry pureadmin "Pure-FTPd menu config" pureadmin
}

pkg_postinst() {
	ewarn "PureAdmin is at a beta-stage right now and it may break your"
	ewarn "configuration. DO NOT use it for safety critical system"
	ewarn "or production use!"
	echo
	elog "You need root-privileges to be able to use PureAdmin."
	elog "This will probably change in the future."
	echo
}
