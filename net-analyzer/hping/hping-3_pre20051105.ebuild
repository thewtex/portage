# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hping/hping-3_pre20051105.ebuild,v 1.5 2009/12/22 20:26:02 jer Exp $

inherit eutils toolchain-funcs

MY_P="${PN}${PV//_pre/-}"
DESCRIPTION="A ping-like TCP/IP packet assembler/analyzer"
HOMEPAGE="http://www.hping.org"
SRC_URI="http://www.hping.org/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="tcl debug"

S="${WORKDIR}/${MY_P}"

DEPEND="net-libs/libpcap
	tcl? ( dev-lang/tcl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/bytesex.h.patch

	# Correct hard coded values
	sed -i "9s:gcc:$(tc-getCC):" Makefile.in
	sed -i "10s:/usr/bin/ar:$(tc-getAR):" Makefile.in
	sed -i "11s:/usr/bin/ranlib:$(tc-getRANLIB):" Makefile.in
	sed -i "12s:-O2:${CFLAGS}:" Makefile.in
}

src_compile() {

	myconf=""
	use tcl || myconf="--no-tcl"
	econf ${myconf} || die "configure failed"

	if use debug; then
		emake || die "make failed"
	else
		emake DEBUG="" || die "make failed"
	fi
}

src_install () {
	dosbin hping3
	dosym /usr/sbin/hping3 /usr/sbin/hping
	dosym /usr/sbin/hping3 /usr/sbin/hping2

	doman docs/hping3.8

	dodoc INSTALL NEWS README TODO AUTHORS BUGS CHANGES
}
