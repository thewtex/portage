# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.3.5.ebuild,v 1.3 2010/03/11 18:37:37 ranger Exp $

EAPI="2"

KMNAME="${PN/-*/}"
KMNOMODULE="true"

inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

KMEXTRA="
	kmtrace/
	kpartloader/
	kprofilemethod/
	kspy/
	kunittest/
	poxml/
	scheck/
"
