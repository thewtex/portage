# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-info flag-o-matic

DESCRIPTION="Device-mapper RAID tool and library"
HOMEPAGE="http://people.redhat.com/~heinzm/sw/dmraid/"
#SRC_URI="http://people.redhat.com/~heinzm/sw/dmraid/src/${P/_/.}.tar.bz2"
# Temporarily set to testing prerelease source URI
SRC_URI="http://people.redhat.com/~heinzm/sw/dmraid/tst/old/${P/_/.}-pre1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static selinux genkernel"

DEPEND="sys-fs/device-mapper
	selinux? ( sys-libs/libselinux
		   sys-libs/libsepol )
	genkernel? ( sys-kernel/genkernel )"
S=${WORKDIR}/${PN}/${PV/_/.}

pkg_setup() {
	if kernel_is lt 2 6; then
		ewarn "You are using a kernel < 2.6"
		ewarn "DMraid uses recently introduced Device-Mapper features."
		ewarn "These might be unavailable in the kernel you are running now."
	fi
	if use static && use selinux; then
		eerror "ERROR - cannot compile static with libselinux / libsepol"
		die "USE flag conflicts."
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-${PV}-man-make.patch
	use static || epatch ${FILESDIR}/${PN}-${PV}-asr-make.patch
	cd ${S}
}

src_compile() {
	local myconf

	#inlining doesnt seem to work for dmraid
	filter-flags -fno-inline

	econf   $(use_enable static static_link) \
		$(use_enable selinux libselinux) \
		$(use_enable selinux libsepol) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	# Put the distfile into /usr/share/genkernel/pkg for genkernel
	# and patch the genkernel.conf in /etc with the new version
	if use genkernel; then
		dodir /usr/share/genkernel/pkg
		cp ${DISTDIR}/${A} ${D}/usr/share/genkernel/pkg/${A}

		dodir /etc
		cp /etc/genkernel.conf ${D}/etc/genkernel.conf
		local MY_PV=${PV/_/.}
		sed "/^DMRAID_VER=/i\# To use ${P} from portage instead, use the following\:\n# DMRAID_VER=\"${MY_PV}\"\n# DMRAID_SRCTAR=\"\$\{GK_SHARE\}\/pkg\/${A}\"" -i ${D}/etc/genkernel.conf
	fi

	dodoc CHANGELOG README TODO KNOWN_BUGS doc/*
}

pkg_postinst() {
	einfo "For booting Gentoo from Device-Mapper RAID you can use Genkernel."
	einfo " "
	if use genkernel; then
		einfo "Be sure to update the DMRAID options in /etc/genkernel.conf to "
		einfo "make Genkernel use this DMraid version"
		einfo " "
		einfo "To add DMraid support to your Genekernel initrd, add the --dmraid flag:"
		einfo "genkernel --dmraid --udev all"
	else
		einfo "Genkernel will generate the kernel and the initrd with a statically "
		einfo "linked dmraid binary (its own version - not this version):"
		einfo "emerge -av sys-kernel/genkernel"
		einfo "genkernel --dmraid --udev all"
	fi
	ewarn " "
	ewarn "DMraid should be safe to use, but no warranties can be given"
	ewarn " "
}
