# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit python eutils

DESCRIPTION="Highly efficient file backup system based on the git packfile format"
HUB_USER="apenwarr"
MAN_HASH="1783a57"
SRC_HASH="d8d6406"
SRC_URI="
	https://github.com/${HUB_USER}/${PN}/tarball/${P} -> ${P}.tar.gz
	https://github.com/${HUB_USER}/${PN}/tarball/${MAN_HASH} -> ${P}-man.tar.gz"
HOMEPAGE="https://github.com/${HUB_USER}/${P}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fuse web"

DEPEND=""
RDEPEND="
	app-arch/par2cmdline
	dev-vcs/git
	fuse? ( dev-python/fuse-python )
	web? ( www-servers/tornado )"

S="${WORKDIR}/${HUB_USER}-${PN}-${SRC_HASH}"

src_prepare() {
	epatch "${FILESDIR}/0001-dont-use-bundled-tornado.patch"

	if ! use web; then
		epatch "${FILESDIR}/0002-dont-install-bup-web.patch"
		rm cmd/web-cmd.py "${WORKDIR}/${HUB_USER}-${PN}-${MAN_HASH}/bup-web.1"
	fi
	if ! use fuse; then
		rm cmd/fuse-cmd.py "${WORKDIR}/${HUB_USER}-${PN}-${MAN_HASH}/bup-fuse.1"
	fi

	epatch "${FILESDIR}/0003-dont-generate-manpages.patch"
	epatch "${FILESDIR}/0004-gentoofy-paths.patch"
	sed -i \
		-e "s|/usr/lib/bup|$(python_get_sitedir)/${P}|" \
		main.py Makefile || die "sed failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	doman "${WORKDIR}/${HUB_USER}-${PN}-${MAN_HASH}"/* || die "doman failed"
	dodoc README.md DESIGN
}
