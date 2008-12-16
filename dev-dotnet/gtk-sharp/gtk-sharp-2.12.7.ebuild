# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-2.12.7.ebuild,v 1.2 2008/12/14 15:27:09 loki_val Exp $

EAPI="2"

inherit eutils mono autotools

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"
SRC_URI="mirror://gnome/sources/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="+glade doc"

RDEPEND=">=dev-lang/mono-1.1.9
		glade? ( >=gnome-base/libglade-2.3.6 )
		 >=x11-libs/gtk+-2.12
		!dev-dotnet/glade-sharp"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19
		doc? ( >=virtual/monodoc-1.1.8 )"

RESTRICT="test"

src_prepare() {

	#Upstream: https://bugzilla.novell.com/show_bug.cgi?id=$bugno

	# Upstream bug #421063
	epatch "${FILESDIR}/${PN}-2.12.0-parallelmake.patch"
	epatch "${FILESDIR}/${PN}-2.12.0-doc-parallelmake.patch"
	# Upstream bug #443180
	epatch "${FILESDIR}/${PN}-2.12.0-noautomagic.patch"

	# Upstream bug #443175
	sed -i -e ':^CFLAGS=:d' "${S}/configure.in"

	# disable building of samples (#16015)
	sed -i -e "s:sample::" Makefile.am

	eautoreconf
}

src_configure() {
	econf $(use_enable doc monodoc) $(use_enable glade) || die "configure failed"
}

src_compile() {
	LANG=C emake || die
}

src_install () {
	emake DESTDIR="${D}" install || die

	dodoc README* ChangeLog
}