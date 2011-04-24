# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

DESCRIPTION="List portage profiles and other portage directories"
GITHUB_USER="tarsius"
GITHUB_REPO="${PN}"
GITHUB_TAG="${PV}"
HOMEPAGE="https://github.com/${GITHUB_USER}/${GITHUB_REPO}"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=sys-apps/portage-9999"

src_prepare() {
	mv tarsius-${PN}-* ${PF}
}

src_compile() { :; }

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "doman failed"
	insinto /etc
	doins ${PN}.conf || die "doins failed"
}
