# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gf2x/gf2x-1.0-r1.ebuild,v 1.1 2011/07/08 11:25:31 tomka Exp $

EAPI=2

inherit autotools-utils

PID=27999 # hack

DESCRIPTION="C/C++ routines for fast arithmetic in GF(2)[x]"
HOMEPAGE="http://gf2x.gforge.inria.fr/"
SRC_URI="http://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

IUSE="bindist"
DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local myeconfargs=(
		ABI=default
		)

	if use bindist ; then
		if use x86 ; then
			myeconfargs+=(
				--disable-sse2
			)
		fi
		if use amd64 ; then
			myeconfargs+=(
				--disable-pclmul
			)
		fi
	fi

	autotools-utils_src_configure
}

src_install() {
	dodoc ChangeLog README AUTHORS BUGS
	autotools-utils_src_install
}
