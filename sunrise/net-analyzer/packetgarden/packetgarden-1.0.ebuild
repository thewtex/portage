# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${P/-/_}_all"

DESCRIPTION="captures information about how you use the internet and use it to
grow a private world"
HOMEPAGE="http://www.packetgarden.com/"
SRC_URI="http://selectparks.net/~julian/pg/dists/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/dpkt
	dev-python/imaging
	dev-python/geoip-python
	dev-python/pypcap
	>=dev-python/soya-0.13_rc1
	x11-libs/gksu"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if !built_with_use dev-python/soya openal ; then
		eerror "${PN} needs dev-python/soya built with openal USE flag enabled."
		die "dev-python/soya without openal"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-launcher.patch"
	epatch "${FILESDIR}/${P}-games-path.patch"
	mv stop_capture packetgarden-stop
}

src_install() {
	dobin packetgarden packetgarden-stop
	insinto /usr/share/${PN}
	doins -r config data guide labels logs stats pg_*.py
	dodoc README_LINUX.txt
}

pkg_postinst() {
	elog "In order to get a good performance it is very recomended"
	elog "to install dev-python/psyco"
}
