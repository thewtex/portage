# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/media-player-info/media-player-info-14.ebuild,v 1.2 2011/07/15 19:18:24 ssuominen Exp $

EAPI=4

DESCRIPTION="A repository of data files describing media player capabilities"
HOMEPAGE="http://cgit.freedesktop.org/media-player-info/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=sys-fs/udev-171[hwdb] <sys-fs/udev-171[extras] )"
DEPEND="${RDEPEND}"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
