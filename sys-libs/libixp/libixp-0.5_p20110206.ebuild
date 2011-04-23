# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Standalone client/server 9P library"
HOMEPAGE="http://libs.suckless.org/libixp"
SRC_URI="https://github.com/downloads/tarsius/tarsius-overlay/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e "/^ *PREFIX/s|=.*|= /usr|" \
		-e "/^ *ETC/s|=.*|= /etc|" \
		-e "/^ *CFLAGS/s|=|+=|" \
		-e "/^ *LDFLAGS/s|=|+=|" \
		-e "/^ *LIBDIR/s|=.*|= \$(PREFIX)/$(get_libdir)|"\
		"${S}"/config.mk || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
