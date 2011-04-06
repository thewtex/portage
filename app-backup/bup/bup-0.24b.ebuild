# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils

DESCRIPTION="Highly efficient file backup system based on the git packfile format"
HOMEPAGE="http://github.com/apenwarr/${P}"
SRC_URI="http://github.com/apenwarr/bup/tarball/${P} -> ${P}.tar.gz"
SRC_HASH="d8d6406"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse +web"

DEPEND_COMMON="
	app-arch/par2cmdline
	dev-python/fuse-python
	dev-vcs/git
	fuse? ( sys-fs/fuse )
	web? ( www-servers/tornado )"
DEPEND="${DEPEND_COMMON}
	app-text/pandoc"
RDEPEND="${DEPEND_COMMON}"

S="${WORKDIR}/apenwarr-${PN}-${SRC_HASH}"

src_prepare() {
	sed -i \
		-e "/^DOCDIR/s/${PN}/${P}/" \
		-e "/^LIBDIR/s/${PN}/${P}/" \
		Makefile || die "sed failed"
	sed -i \
		-e "/^if os.path.exists(\"%s/s/${PN}/${P}/" \
		-e "/^    cmdpath =/s/${PN}/${P}/" \
		-e "/^    libpath =/s/${PN}/${P}/" \
		main.py || die "sed failed"
	epatch "${FILESDIR}/0001-dont-use-bundled-tornado.patch"
	if ! use web; then
		epatch "${FILESDIR}/0002-dont-install-bup-web.patch"
		rm cmd/web-cmd.py
	fi
	use fuse || rm cmd/fuse-cmd.py
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README.md DESIGN
}

src_test() {
	emake test || die "emake test failed"
}
