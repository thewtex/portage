# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils webapp

GIT_V="1.6.1.1"

DESCRIPTION="a fast web-interface for git repositories"
HOMEPAGE="http://hjemli.net/git/cgit/about/"
SRC_URI="mirror://kernel/software/scm/git/git-${GIT_V}.tar.bz2
	http://hjemli.net/git/cgit/snapshot/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="${IUSE} doc"

RDEPEND="sys-libs/zlib
	dev-libs/openssl"
DEPEND="${RDEPEND}
  doc? ( app-text/asciidoc )"

EAPI="2"

S=${WORKDIR}/cgit-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rmdir git
	mv ${WORKDIR}/git-${GIT_V} git
	sed -i \
		-e 's:\(/etc/\)\(\(cgit\)rc\):\1\3/\2:' \
		Makefile
}

src_prepare() {
	epatch "${FILESDIR}/0001-make-cgitrc.5.txt-asciidoc-manpage-compatible.patch" 
}

src_compile() {
	if use doc; then
		a2x -f manpage cgitrc.5.txt || die "man page generation failed"
	fi

	webapp_src_compile
}

src_install() {
	webapp_src_preinst

	dodoc README
	if use doc; then
	  doman cgitrc.5
	fi
	
	insinto ${MY_HTDOCSDIR}
	newins cgit cgit.cgi || die "newins failed"
	doins cgit.css cgit.png || die "doins failed"

	insinto /etc/cgit
	doins "${FILESDIR}"/cgitrc.example || die "doins failed"

	dodir /var/cache/cgit
	keepdir /var/cache/cgit

	# This is just plain wrong, how to do it correctly?
	fperms +x "${MY_HTDOCSDIR}"/cgit.cgi || die "fperms failed"

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
