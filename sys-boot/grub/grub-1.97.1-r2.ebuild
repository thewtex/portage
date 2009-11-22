# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit autotools mount-boot flag-o-matic toolchain-funcs

FGRUB=grub-funtoo-1.2
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz http://www.funtoo.org/archive/grub/${FGRUB}.tar.bz2"

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
RESTRICT="nomirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags debug static mkfont"

RDEPEND=">=sys-libs/ncurses-5.2-r5 dev-libs/lzo mkfont? ( >=media-libs/freetype-2 )"
DEPEND="${RDEPEND}"
PROVIDE="virtual/bootloader"

export STRIP_MASK="*/grub/*/*.mod"
QA_EXECSTACK="sbin/grub-probe sbin/grub-setup sbin/grub-mkdevicemap"

src_unpack() {
	unpack ${A}; cd "${S}"
	cat ${DISTDIR}/${PATCH} | patch -p1 || die "patch failed"
	eautoconf; eautoheader
}

src_compile() {
	use custom-cflags || unset CFLAGS CPPFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
		--disable-werror \
		--sbindir=/sbin \
		--bindir=/bin \
		--libdir=/$(get_libdir) \
		--disable-efiemu \
		$(use_enable mkfont grub-mkfont ) \
		$(use_enable debug mm-debug) \
		$(use_enable debug grub-emu) \
		$(use_enable debug grub-emu-usb) \
		$(use_enable debug grub-fstest)
	emake -j1 || die "making regular stuff"

	# As of 1.97.1, GRUB still needs -j1 to build. Reason: grub_script.tab.c
}

src_install() {
	emake DESTDIR="${D}" install || die

	rm -rf ${D}/etc/default
	rm -rf ${D}/etc/grub.d/*

	cp -a ${WORKDIR}/${FGRUB}/* ${D}
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
