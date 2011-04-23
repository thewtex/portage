# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

DESCRIPTION="A minimal word processor that lets you focus on writing"
HOMEPAGE="http://www.pyroom.org/"
SRC_URI="http://launchpad.net/${PN}/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="dev-python/pyxdg
	dev-python/pygtk
	gnome? ( dev-python/gconf-python )"
DEPEND="sys-devel/gettext"

DOCS="AUTHORS CHANGELOG"

pkg_postinst() { 
	elog "If you get an Error like"
	elog "\"AttributeError: \'list\' object has no attribute \'encode\'"
	elog "you need to create a startup-script like the following:"
	elog "#!/bin/sh"
	elog "#Script for starting PyRoom"
	elog ""
	elog "unset LANGUAGE"
	elog "pyroom"
	elog "export LANGUAGE=en_US.UTF-8"
}
