# Copyright 1999-2011 Gentoo Foundation
# Copyright 2011 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
#

inherit linux-mod eutils flag-o-matic

DESCRIPTION="Open Source iSCSI target with professional features"
HOMEPAGE="http://iscsitarget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P%%_p20110821}.tar.gz"

EAPI="2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="iscsitarget needs support for CRC32C in your kernel."
S="${S%%_p20110821}"
MODULE_NAMES="iscsi_trgt(misc:${S}/kernel)"

src_prepare() {
	

	# Applying the diff between 14.20.2 and the trunk taken revision 453 (latest available as of Aug, 21st 2011)
	# As of revision #453, the upstream has integrated changes for bug #340449 (NIPQUAD macro), we don't need to apply them anymore
	epatch "${FILESDIR}/${P}-svn-r453.patch"

	# Even at revision 453, iscsitarget still have issues with LDFLAGS conformance (several flags are forced especially -O2), This issue is
	# similar to bug #350742 however the Makefile in the 'usr' subdirectory has changed so the patch for that bug does work any more.
	epatch "${FILESDIR}/${P}-respect-ldflags.patch"

	# Even at trunk revision 453, patch for bug #180619 is still valid
	epatch "${FILESDIR}/${PN}-0.4.15-isns-set-scn-flag.patch"

	# Version comparison enhancement (especially needed with Linux 3.x series), see comments at http://sourceforge.net/projects/iscsitarget/develop
	epatch "${FILESDIR}/${P}-makefile.patch"
	
	# Our out-of-tree kernel modules must be compiled giving M=... instead of SUBDIRS=..., so make sure Makefile follows that guideline
	convert_to_m "${S}"/Makefile
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
