# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xkb/xfce4-xkb-0.5.2.ebuild,v 1.1 2008/11/10 09:36:11 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="XKB layout switching panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND=">=x11-libs/libxklavier-3.2
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/intltool
	x11-proto/kbproto"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin