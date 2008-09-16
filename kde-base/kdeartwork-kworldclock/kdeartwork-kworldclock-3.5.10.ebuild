# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.5.10.ebuild,v 1.2 2008/09/14 02:26:16 mr_bones_ Exp $

KMMODULE=kworldclock
KMNAME=kdeartwork
EAPI="1"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=kde-base/kworldclock-${PV}:${SLOT} >=kde-base/kdetoys-${PV}:${SLOT} )"