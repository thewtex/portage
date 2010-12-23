# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Miscellaneous portage utilities"
HOMEPAGE="http://github.com/tarsius/${PN}/"
SRC_URI="http://github.com/tarsius/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/pandoc"
RDEPEND=">=app-portage/gentoolkit-0.3.0_rc10-r1"

src_prepare() {
	mv tarsius-${PN}-* ${PF}
}

src_compile() {
	emake -C doc man || die "make man failed"
}

src_install() {
	dobin bin/*
	doman doc/*.1
	insinto /etc
	doins etc/elone.conf
}
