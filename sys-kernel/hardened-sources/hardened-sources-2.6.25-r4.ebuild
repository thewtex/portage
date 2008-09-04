# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hardened-sources/hardened-sources-2.6.25-r4.ebuild,v 1.3 2008/08/31 19:06:09 nixnut Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version

HGPV=${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-5
HGPV_URI="http://confucius.dh.bytemark.co.uk/~kerin.millar/distfiles/hardened-patches-${HGPV}.extras.tar.bz2
	mirror://gentoo/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_LIST="${DISTDIR}/hardened-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.4.patch"
DESCRIPTION="Hardened kernel sources ${OKV}"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86"

pkg_postinst() {
	kernel-2_pkg_postinst

	local GRADM_COMPAT="sys-apps/gradm-2.1.12*"

	ewarn
	ewarn "As of ${CATEGORY}/${PN}-2.6.24 the predefined"
	ewarn "\"Hardened [Gentoo]\" grsecurity level has been removed."
	ewarn "Two improved predefined security levels replace it:"
	ewarn "\"Hardened Gentoo [server]\" and \"Hardened Gentoo [workstation]\""
	ewarn
	ewarn "Those who intend to use one of these predefined grsecurity levels"
	ewarn "should read the help associated with the level. Users importing a"
	ewarn "kernel configuration from a kernel prior to ${PN}-2.6.24,"
	ewarn "should review their selected grsecurity/PaX options carefully."
	ewarn
	ewarn
	ewarn "Users of grsecurity's RBAC system must ensure they are using"
	ewarn "${GRADM_COMPAT}, which is compatible with kernel series ${OKV}."
	ewarn "Therefore, it is strongly recommended that the following command is"
	ewarn "issued prior to booting a ${P} series kernel for"
	ewarn "the first time:"
	ewarn
	ewarn "emerge -na =${GRADM_COMPAT}"
	ewarn
}