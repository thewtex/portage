# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit autotools mount-boot flag-o-matic toolchain-funcs

SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz mirror://gentoo/${P}.tar.gz"

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"

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
	cat ${FILESDIR}/grub-1.97-funtoo.patch | patch -p1 || die "patch failed"
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
	emake || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die

	# use special funtoo config to match special funtoo changes
	rm -rf ${D}/etc/default
	newconfd ${S}/funtoo/grub.defaults grub || die

	into /
	dosbin ${S}/funtoo/grub-update || die

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
