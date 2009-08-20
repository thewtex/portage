# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/kphone/kphone-4.2-r1.ebuild,v 1.2 2009/08/19 17:49:53 vostorga Exp $

inherit qt3 eutils toolchain-funcs

DESCRIPTION="A SIP user agent for Linux, with which you can initiate VoIP connections over the Internet."
HOMEPAGE="http://sourceforge.net/projects/kphone"
SRC_URI="http://www.wirlab.net/kphone/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="alsa debug jack"

S=${WORKDIR}/${PN}

RDEPEND="=x11-libs/qt-3*
	dev-libs/openssl
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}"

# TODO: support for Secure RTP, needs libSRTP in portage

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/kphone-4.2-gcc4.diff
	epatch "${FILESDIR}"/kphone-4.2-CVE-2006-2442.diff
	epatch "${FILESDIR}"/${P}-parse-fr.diff
	sed -i -e "s:\$CFLAGS -O3:\$CFLAGS $CFLAGS:" "${S}"/configure
	#Pre-stripped file, bug 252015
	sed -i -e "/install --strip/ s:--strip::" "${S}"/kphone/Makefile.in
}

src_compile() {
	local myconf="$(use_enable alsa) $(use_enable jack)
	              $(use_enable debug) --disable-srtp"
	econf ${myconf} || die
	emake CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES README
	make_desktop_entry "kphone" KPhone "/usr/share/apps/kphone/icons/large-kphone.png" "Telephony;Qt"
}
