# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-bin/icedtea-bin-7.2.0-r2.ebuild,v 1.1 2011/11/28 14:01:54 sera Exp $

EAPI="4"

inherit java-vm-2 prefix

dist="http://dev.gentoo.org/~caster/distfiles/"
TARBALL_VERSION="${PV}"

DESCRIPTION="A Gentoo-made binary build of the IcedTea JDK"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="
	amd64? ( ${dist}/${PN}-core-${TARBALL_VERSION}-amd64.tar.bz2 )
	x86? ( ${dist}/${PN}-core-${TARBALL_VERSION}-x86.tar.bz2 )
	doc? ( ${dist}/${PN}-doc-${TARBALL_VERSION}.tar.bz2 )
	examples? (
		amd64? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-amd64.tar.bz2 )
		x86? ( ${dist}/${PN}-examples-${TARBALL_VERSION}-x86.tar.bz2 )
	)
	nsplugin? (
		amd64? ( ${dist}/${PN}-nsplugin-${TARBALL_VERSION}-amd64.tar.bz2 )
		x86? ( ${dist}/${PN}-nsplugin-${TARBALL_VERSION}-x86.tar.bz2 )
	)
	source? ( ${dist}/${PN}-src-${TARBALL_VERSION}.tar.bz2 )"

LICENSE="GPL-2-with-linking-exception"
SLOT="7"
KEYWORDS="~amd64 ~x86"

IUSE="X alsa cjk doc examples nsplugin source"
REQUIRED_USE="nsplugin? ( X )"
RESTRICT="strip"

RDEPEND="
	>=sys-devel/gcc-4.3
	>=sys-libs/glibc-2.11.2
	>=media-libs/giflib-4.1.6-r1
	virtual/jpeg
	media-libs/lcms:2
	>=media-libs/libpng-1.5
	>=sys-libs/zlib-1.2.3-r1
	X? (
		>=dev-libs/atk-1.30.0
		>=dev-libs/glib-2.20.5:2
		media-fonts/dejavu
		>=media-libs/fontconfig-2.6.0-r2:1.0
		>=media-libs/freetype-2.3.9:2
		>=net-print/cups-1.4
		>=x11-libs/cairo-1.8.8
		x11-libs/gdk-pixbuf:2
		>=x11-libs/gtk+-2.20.1:2
		>=x11-libs/libX11-1.3
		>=x11-libs/libXext-1.1
		>=x11-libs/libXi-1.3
		x11-libs/libXrender
		>=x11-libs/libXtst-1.1
		>=x11-libs/pango-1.24.5
		cjk? (
			media-fonts/arphicfonts
			media-fonts/baekmuk-fonts
			media-fonts/lklug
			media-fonts/lohit-fonts
			media-fonts/sazanami
		)
	)
	alsa? ( >=media-libs/alsa-lib-1.0.20 )"

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}/${dest}"
	dodir "${dest}"

	# doins can't handle symlinks.
	cp -pRP bin include jre lib man "${ddest}" || die

	# Remove on next bump as the needed marks are already set by icedtea ebuild.
	java-vm_set-pax-markings "${ddest}"

	dodoc ../doc/{ASSEMBLY_EXCEPTION,THIRD_PARTY_README}

	if use doc; then
		dohtml -r ../doc/html/*
	fi

	if use examples; then
		cp -pRP share/{demo,sample} "${ddest}" || die
	fi

	if use source; then
		cp src.zip "${ddest}" || die
	fi

	if use nsplugin; then
		cp -pPR ../icedtea-web-bin-${SLOT} "${ddest}"/.. || die
		install_mozilla_plugin "/opt/icedtea-web-bin-${SLOT}/$(get_libdir)/IcedTeaPlugin.so"
		docinto icedtea-web
		dodoc ../doc/icedtea-web/*
	fi

	# Remove after next bump, handled by icedtea ebuild. Bug 390663
	cp "${FILESDIR}"/fontconfig.Gentoo.properties.src "${T}"/fontconfig.Gentoo.properties || die
	eprefixify "${T}"/fontconfig.Gentoo.properties
	insinto "${dest}"/jre/lib
	doins "${T}"/fontconfig.Gentoo.properties

	set_java_env
	java-vm_revdep-mask "${dest}"
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if use nsplugin; then
		elog "The icedtea-bin-${SLOT} browser plugin can be enabled using eselect java-nsplugin"
		elog "Note that the plugin works only in browsers based on xulrunner-1.9.1+"
		elog "such as Firefox 3.5+ and recent Chromium versions."
	fi
}
