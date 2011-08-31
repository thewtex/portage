# Copyright 1999-2011 Gentoo Foundation
# Copyright 2011 Funtoo Technologies

# Same as Gentoo -9999 but with removed conditional blocks as this ebuild is -9999 (code cleanup)

inherit linux-mod eutils flag-o-matic subversion autotools

ESVN_REPO_URI="http://iscsitarget.svn.sourceforge.net/svnroot/iscsitarget/trunk"

DESCRIPTION="Open Source iSCSI target with professional features"
HOMEPAGE="http://iscsitarget.sourceforge.net/"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

MODULE_NAMES="iscsi_trgt(misc:${S}/kernel)"
CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="iscsitarget needs support for CRC32C in your kernel."

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	emake KSRC="${KERNEL_DIR}" usr || die

	unset ARCH
	emake KSRC="${KERNEL_DIR}" kernel || die
}

src_install() {
	einfo "Installing userspace"

	# Install ietd into libexec; we don't need ietd to be in the path
	# for ROOT, since it's just a service.
	exeinto /usr/libexec
	doexe usr/ietd || die

	dosbin usr/ietadm || die

	insinto /etc
	doins etc/ietd.conf etc/initiators.allow || die

	# We moved ietd in /usr/libexec, so update the init script accordingly.
	sed -e 's:/usr/sbin/ietd:/usr/libexec/ietd:' "${FILESDIR}"/ietd-init.d-2 > "${T}"/ietd-init.d
	newinitd "${T}"/ietd-init.d ietd || die
	newconfd "${FILESDIR}"/ietd-conf.d ietd || die

	# Lock down perms, per bug 198209
	fperms 0640 /etc/ietd.conf /etc/initiators.allow

	doman doc/manpages/*.[1-9] || die
	dodoc ChangeLog README RELEASE_NOTES README.initiators README.vmware || die

	einfo "Installing kernel module"
	unset ARCH
	linux-mod_src_install || die
}
