# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/open-vm-tools/open-vm-tools-0.0.20110923.491607.ebuild,v 1.2 2011/11/11 14:20:19 vadimk Exp $

EAPI="2"

inherit eutils pam versionator

MY_DATE="$(get_version_component_range 3)"
MY_BUILD="$(get_version_component_range 4)"
MY_PV="${MY_DATE:0:4}.${MY_DATE:4:2}.${MY_DATE:6:2}-${MY_BUILD}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Opensourced tools for VMware guests"
HOMEPAGE="http://open-vm-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc fuse icu +pic xinerama"

RDEPEND="app-emulation/open-vm-tools-kmod
	dev-libs/glib:2
	dev-libs/libdnet
	sys-apps/ethtool
	sys-process/procps
	virtual/pam
	X? (
		dev-cpp/gtkmm:2.4
		x11-base/xorg-server
		x11-drivers/xf86-input-vmmouse
		x11-drivers/xf86-video-vmware
		x11-libs/gtk+:2
		x11-libs/libnotify
		x11-libs/libX11
		x11-libs/libXtst
	)
	fuse? ( sys-fs/fuse )
	icu? ( dev-libs/icu )
	xinerama? ( x11-libs/libXinerama )
	"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig
	virtual/linux-sources
	sys-apps/findutils
	"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	#use unity && ! use X && die 'The Unity USE flag requires "X" USE flag as well'
	#use unity && ! use xinerama && die 'The Unity USE flag requires xinerame USE="xinerama" as well'

	enewgroup vmware
}

src_prepare() {
	epatch "${FILESDIR}/default-scripts.patch"
	#epatch "${FILESDIR}/checkvm-pie-safety.patch"
	#sed -i -e 's/proc-3.2.7/proc/g' configure || die "sed configure failed"
	# Do not filter out Werror
	# Upstream Bug  http://sourceforge.net/tracker/?func=detail&aid=2959749&group_id=204462&atid=989708
	# sed -i -e 's/CFLAGS=.*Werror/#&/g' configure || die "sed comment out Werror failed"
	sed -i -e 's:\(TEST_PLUGIN_INSTALLDIR=\).*:\1\$libdir/open-vm-tools/plugins/tests:g' configure || die "sed test_plugin_installdir failed"
}

src_configure() {
	econf \
		--with-procps \
		--with-dnet \
		--without-kernel-modules \
		$(use_enable doc docs) \
		--docdir=/usr/share/doc/${PF} \
		$(use_with X x) \
		$(use_with X gtk2) \
		$(use_with X gtkmm) \
		$(use_with icu) \
		$(use_with pic) \
		$(use_enable xinerama multimon)

	# Bugs 260878, 326761
	find ./ -name Makefile | xargs sed -i -e 's/-Werror//g'  || die "sed out Werror failed"
}

src_compile() {
	emake || die "failed to compile"
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"

	rm "${D}"/etc/pam.d/vmtoolsd
	pamd_mimic_system vmtoolsd auth account

	rm "${D}"/usr/$(get_libdir)/*.la
	rm "${D}"/usr/$(get_libdir)/open-vm-tools/plugins/common/*.la

	newinitd "${FILESDIR}/open-vm-tools.initd" vmware-tools || die "failed to newinitd"
	newconfd "${FILESDIR}/open-vm.confd" vmware-tools || die "failed to newconfd"

	if use X;
	then
		fperms 4755 "/usr/bin/vmware-user-suid-wrapper" || die

		dobin "${S}"/scripts/common/vmware-xdg-detect-de

		insinto /etc/xdg/autostart
		doins "${FILESDIR}/open-vm-tools.desktop" || die "failed to install .desktop"

		elog "To be able to use the drag'n'drop feature of VMware for file"
		elog "exchange, please add the users to the 'vmware' group."
	fi
	elog "Add 'vmware-tools' service to the default runlevel."
}
