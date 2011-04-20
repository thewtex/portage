# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-plugins/nessus-plugins-2.2.9.ebuild,v 1.4 2011/04/20 11:00:43 jlec Exp $

EAPI="1"

inherit toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (nessus-plugins)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/nessus-plugins-GPL-${PV}.tar.gz"

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

DEPEND="
	dev-libs/openssl:0
	~net-analyzer/nessus-core-${PV}
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	tc-export CC
	econf
	emake || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		install || die "make install failed"
	dodoc docs/*.txt
}
