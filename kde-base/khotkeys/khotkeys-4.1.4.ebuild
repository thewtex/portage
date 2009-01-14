# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khotkeys/khotkeys-4.1.4.ebuild,v 1.1 2009/01/13 22:05:23 alexxy Exp $

EAPI="2"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkworkspace-${PV}:${SLOT}
	x11-libs/libXtst"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/kworkspace/"
