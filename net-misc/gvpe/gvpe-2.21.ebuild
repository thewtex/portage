# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnuconfig multilib

DESCRIPTION="GVPE is a suite designed to provide a virtual private network for multiple nodes over an untrusted network."
SRC_URI="http://ftp.gnu.org/gnu/gvpe/${P}.tar.gz"
HOMEPAGE="http://savannah.gnu.org/projects/gvpe"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6
	sys-apps/iproute2
	dev-libs/libev"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"
	./autogen.sh
	gnuconfig_update
	epatch ${FILESDIR}/gvpe-conf-2.patch
}

src_compile() {
	# slow, but very secure 
	local myconf="--enable-hmac-length=16 --enable-rand-length=8 --enable-digest=aes128"
	econf ${myconf} \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# install documentation
	dodoc AUTHORS COPYING ChangeLog NEWS README
	
	# Empty dir
	dodir /etc/gvpe
	keepdir /etc/gvpe
	dodir /var/lib/run/
	keepdir /var/lib/run/

	# Install the example configuration file
	insinto /etc/gvpe
	doins doc/complex-example/gvpe.conf


	# Install some helper scripts
	exeinto /usr/sbin
	doexe "${FILESDIR}/gvpe-sync"
	#doexe "${FILESDIR}/down.sh"

	# Install the init script
	cp ${FILESDIR}/gvpe.init ${T}/gvpe && doinitd ${T}/gvpe
	cp ${FILESDIR}/gvpe.confd ${T}/gvpe && doconfd ${T}/gvpe
}

pkg_postinst() {
	einfo ""
	einfo "GVPE was compiled with:"
	einfo "	hmac-length=16"
	einfo "	rand-length=8"
	einfo "	digest=aes128"
	einfo ""
	einfo "This uses a 16 byte HMAC checksum to authenticate packets (I guess 8-12"
	einfo "would also be pretty secure ;) and will additionally prefix each packet"
	einfo "with 8 bytes of random data."
	einfo ""
	einfo "Use gvpe-sync to sincronize the configuration and hostkeys to the nodes"
	einfo ""
	einfo ""
	einfo "."
}
