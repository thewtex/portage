# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/iscsitarget/iscsitarget-1.4.20.2.ebuild,v 1.4 2011/02/16 22:16:27 hwoarang Exp $

inherit linux-mod eutils flag-o-matic

ESVN_REPO_URI="http://iscsitarget.svn.sourceforge.net/svnroot/iscsitarget/trunk"

DESCRIPTION="Open Source iSCSI target with professional features"
HOMEPAGE="http://iscsitarget.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion autotools
else
	inherit autotools
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

MODULE_NAMES="iscsi_trgt(misc:${S}/kernel)"
CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="iscsitarget needs support for CRC32C in your kernel."

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack

		if kernel_is -ge 2 6 39; then
			# Those two have been submitted at the upstream level, waiting for inclusion....
			epatch "${FILESDIR}"/${PN}-9999-blockio.c-new-plugging-method+linux-2.6.39.patch
			epatch "${FILESDIR}"/${PN}-9999-iotype.c-rwlock+linux-2.6.39.patch
		fi
	else
		unpack ${A}
		cd "${S}"
		epatch "${FILESDIR}"/${PN}-0.4.15-isns-set-scn-flag.patch #180619
		# NIPQUAD removed in 2.6.36, #340449
		if kernel_is ge 2 6 36; then
			epatch "${FILESDIR}"/iscsitarget-1.4.20.2_kernel-2.6.36.patch
		fi
		epatch_user
		convert_to_m "${S}"/Makefile
		# Respect LDFLAGS. Bug #350742
		epatch "${FILESDIR}"/${PN}-1.4.20.2-respect-flags.patch
	fi
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
