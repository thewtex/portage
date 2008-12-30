# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: .../media-libs/libdlna/libdlna-0.2.3.ebuild $

inherit eutils

DESCRIPTION="A reference open-source implementation of DLNA (Digital Living Network Alliance) standards."
HOMEPAGE="http://libdlna.geexbox.org"
SRC_URI="http://libdlna.geexbox.org/releases/${PN}-${PVR}.tar.bz2"

#S="${WORKDIR}/${PN}-${PVR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug test"

DEPEND="media-video/ffmpeg"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/ffmpeg-libavcodec-fix.patch"
	epatch "${FILESDIR}/ffmpeg-include-fix.patch"
}


src_compile() {

	myconf="--prefix=/usr --disable-static --libdir=/usr/$(get_libdir)"

	if use debug; then
		myconf="${myconf} --disable-strip --enable-debug"
	fi

	# I can't use econf
	# --host is not implemented in ./configure file
	./configure ${myconf} || die "./configure failed"

	emake lib || die "make failed."

	if use test; then
		emake test || die "make test failed."
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed."
	dodoc README ChangeLog
}
