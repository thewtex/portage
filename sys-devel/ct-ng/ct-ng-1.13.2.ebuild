# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ct-ng/ct-ng-1.13.2.ebuild,v 1.1 2011/11/21 10:17:00 blueness Exp $

EAPI="4"

inherit bash-completion-r1

DESCRIPTION="crosstool-ng is a tool to build cross-compiling toolchains"
HOMEPAGE="http://ymorin.is-a-geek.org/projects/crosstool"
MY_P=${P/ct/crosstool}
S=${WORKDIR}/${MY_P}
SRC_URI="http://ymorin.is-a-geek.org/download/crosstool-ng/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

RDEPEND="net-misc/curl
	dev-vcs/cvs
	dev-vcs/subversion"

src_install() {
	emake DESTDIR="${D%/}" install || die "install failed"
	dobashcomp ${PN}.comp
	dodoc README TODO
}
