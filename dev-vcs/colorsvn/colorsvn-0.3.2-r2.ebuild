# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/colorsvn/colorsvn-0.3.2-r2.ebuild,v 1.3 2010/12/29 16:20:06 hwoarang Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Subversion output colorizer"
HOMEPAGE="http://colorsvn.tigris.org"
SRC_URI="http://www.console-colors.de/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-vcs/subversion"
DEPEND="${RDEPEND}"

src_prepare() {
	# rxvt-unicode isn't listed by default :)
	sed -i -e 's:rxvt:rxvt rxvt-unicode:' colorsvnrc-original || die

	epatch "${FILESDIR}/0001-Don-t-colorize-svn-mkdir-bug-321451.-Use-IPC-open2-i.patch"
}

src_compile() {
	# bug 335134
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CREDITS || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "The default settings are stored in /etc/colorsvnrc."
	einfo "They can be locally overridden by ~/.colorsvnrc."
	einfo "An alias to colorsvn was installed for the svn command."
	einfo "In order to immediately activate it do:"
	einfo "\tsource /etc/profile"
	einfo "NOTE: If you don't see colors,"
	einfo "append the output of 'echo \$TERM' to 'colortty' in your colorsvnrc."
	einfo
}
