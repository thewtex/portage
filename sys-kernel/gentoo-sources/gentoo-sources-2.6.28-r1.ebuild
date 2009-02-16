# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.6.28-r1.ebuild,v 1.2 2009/02/13 19:07:44 armin76 Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="2"

inherit kernel-2

detect_version
detect_arch

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree and the reiser4 patchset from namesys"
HOMEPAGE="http://forums.gentoo.org/viewtopic-p-5342918.html#5342918"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} reiser4? ( http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-2.6/reiser4-for-${PV}.patch.gz )"
KEYWORDS="-alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="reiser4"

if use reiser4; then
    UNIPATCH_LIST="${DISTDIR}/reiser4-for-${PV}.patch.gz"
fi

pkg_postinst() {
    kernel-2_pkg_postinst
    einfo "For more info on this patchset, and how to report problems, see:"
    einfo "${HOMEPAGE}"
}
