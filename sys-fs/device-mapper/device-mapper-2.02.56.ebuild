# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.02.56-r2.ebuild,v 1.2 2009/12/29 19:38:35 fauli Exp $

EAPI=2
inherit eutils multilib toolchain-funcs autotools

# This ebuild is copied from the newer lvm2 ebuild because device-mapper is no
# longer maintained independently.
MY_PN=LVM2

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${MY_PN}.${PV}.tgz
		 ftp://sources.redhat.com/pub/lvm2/old/${MY_PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"

IUSE="readline +static selinux"

DEPEND="!!sys-fs/lvm2"

RDEPEND="${DEPEND}
	!<sys-apps/openrc-0.4
	!!sys-fs/lvm-user
	!!sys-fs/clvm
	>=sys-apps/util-linux-2.16"

S="${WORKDIR}/${MY_PN}.${PV}"

pkg_setup() {
	# 1. Genkernel no longer copies /sbin/lvm blindly.
	# 2. There are no longer any linking deps in /usr.
	if use static; then
		elog "Warning, we no longer overwrite /sbin/lvm and /sbin/dmsetup with"
		elog "their static versions. If you need the static binaries,"
		elog "you must append .static the filename!"
	fi
}

src_unpack() {
	unpack ${A}
}

src_prepare() {
	epatch "${FILESDIR}"/lvm2-2.02.56-dmeventd.patch
	epatch "${FILESDIR}"/lvm.conf-2.02.56.patch
	epatch "${FILESDIR}"/lvm2-2.02.56-device-mapper-export-format.patch

	# Merged upstream:
	#epatch "${FILESDIR}"/lvm2-2.02.51-as-needed.patch
	# Merged upstream:
	#epatch "${FILESDIR}"/lvm2-2.02.48-fix-pkgconfig.patch
	# Merged upstream:
	#epatch "${FILESDIR}"/lvm2-2.02.51-fix-pvcreate.patch
	# Fixed differently upstream:
	#epatch "${FILESDIR}"/lvm2-2.02.51-dmsetup-selinux-linking-fix-r3.patch

	epatch "${FILESDIR}"/lvm2-2.02.56-always-make-static-libdm.patch
	epatch "${FILESDIR}"/lvm2-2.02.56-lvm2create_initrd.patch

	eautoreconf
}

src_configure() {
	local myconf
	local buildmode

	myconf="${myconf} --enable-dmeventd"
	myconf="${myconf} --enable-cmdlib"
	myconf="${myconf} --enable-applib"
	myconf="${myconf} --enable-fsadm"

	# Most of this package does weird stuff.
	# The build options are tristate, and --without is NOT supported
	# options: 'none', 'internal', 'shared'
	if use static ; then
		einfo "Building static LVM, for usage inside genkernel"
		buildmode="internal"
		# This only causes the .static versions to become available
		# For recent systems, there are no linkages against anything in /usr anyway.
		# We explicitly provide the .static versions so that they can be included in
		# initramfs environments.
		myconf="${myconf} --enable-static_link"
	else
		ewarn "Building shared LVM, it will not work inside genkernel!"
		buildmode="shared"
	fi

	# dmeventd requires mirrors to be internal, and snapshot available
	# so we cannot disable them
	myconf="${myconf} --with-mirrors=internal"
	myconf="${myconf} --with-snapshots=internal"

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	myconf="${myconf} --sbindir=/sbin --with-staticdir=/sbin"
	econf $(use_enable readline) \
		$(use_enable selinux) \
		--enable-pkgconfig \
		--libdir=/usr/$(get_libdir) \
		${myconf} \
		CLDFLAGS="${LDFLAGS}" || die
}

src_compile() {
	einfo "Doing symlinks"
	pushd include
	emake || die "Failed to prepare symlinks"
	popd

	einfo "Starting main build"
	emake device-mapper || die "compile fail"
}

src_install() {
	emake DESTDIR="${D}" install_device-mapper

	dodir /$(get_libdir)
	# Put these in root so we can reach before /usr is up
	for i in \
		libdevmapper-event{,-lvm2{mirror,snapshot}} \
		libdevmapper \
		; do
		b="${D}"/usr/$(get_libdir)/${i}
		if [ -f "${b}".so ]; then
			mv -f "${b}".so* "${D}"/$(get_libdir) || die
			gen_usr_ldscript ${i}.so || die
		fi
	done

	dodoc README VERSION WHATS_NEW doc/*.{conf,c,txt}

	# move shared libs to /lib(64)
	dolib.a libdm/ioctl/libdevmapper.a || die "dolib.a libdevmapper.a"
	#gen_usr_ldscript libdevmapper.so

	insinto /etc
	doins "${FILESDIR}"/dmtab
	insinto /$(get_libdir)/rcscripts/addons
	doins "${FILESDIR}"/dm-start.sh

	# Device mapper stuff
	newinitd "${FILESDIR}"/device-mapper.rc-1.02.51-r2 device-mapper || die
	newconfd "${FILESDIR}"/device-mapper.conf-1.02.22-r3 device-mapper || die

	newinitd "${FILESDIR}"/1.02.22-dmeventd.initd dmeventd || die
	dolib.a daemons/dmeventd/libdevmapper-event.a \
	|| die "dolib.a libdevmapper-event.a"
	#gen_usr_ldscript libdevmapper-event.so

	insinto /etc/udev/rules.d/
	newins "${FILESDIR}"/64-device-mapper.rules-1.02.49-r2 64-device-mapper.rules || die
}

src_test() {
	einfo "Testcases disabled because of device-node mucking"
	einfo "If you want them, compile the package and see ${S}/tests"
}
