# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/openvz-sources/openvz-sources-2.6.18.028.066.7.ebuild,v 1.1 2009/11/26 19:12:49 pva Exp $

ETYPE="sources"

CKV=2.6.18
OKV=${OKV:-${CKV}}
if [[ ${PR} == "r0" ]]; then
KV_FULL=${CKV}-${PN/-*}-028.066.10
else
KV_FULL=${CKV}-${PN/-*}-028.066.10-${PR}
fi
OVZ_KERNEL="028stab066"
OVZ_REV="10"
EXTRAVERSION=-${OVZ_KERNEL}
KERNEL_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2"

inherit kernel-2
detect_version

# gcc 4.1 to compile

RDEPEND="=sys-devel/gcc-4.1*"
KEYWORDS="amd64 ppc64 sparc x86"
IUSE=""
PATCHV="164.2.1.el5"
DESCRIPTION="Full sources including OpenVZ patchset for the 2.6.18 kernel tree"
HOMEPAGE="http://www.openvz.org"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://download.openvz.org/kernel/branches/rhel5-${CKV}/${OVZ_KERNEL}.${OVZ_REV}/patches/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/patch-${PATCHV}.${OVZ_KERNEL}.${OVZ_REV}-combined.gz
${FILESDIR}/${PN}-2.6.18.028.064.7-bridgemac.patch"

K_EXTRAEINFO="This openvz kernel uses RHEL5 patchset instead of vanilla kernel.
This patchset considered to be more stable and supported by upstream.

This kernel is intended to be built using a specific configuration, and fails to
build in many configurations so please always start with a .config provided by
the OpenVZ team from http://wiki.openvz.org/Download/kernel/rhel5/${OVZ_KERNEL}
- customize the config by enabling boot-related device drivers and filesystems
  so they are part of the kernel"

K_EXTRAEWARN="This kernel is stable only when built with gcc-4.1.x and is known
to oops in random places if built with newer compilers. To build, use gcc-config
to switch to gcc-4.1, source /etc/profile and then build bzImage and modules.
Then use gcc-config to switch back to your default compiler."
