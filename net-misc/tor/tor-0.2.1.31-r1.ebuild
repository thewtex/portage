# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.2.1.31-r1.ebuild,v 1.1 2011/11/26 15:44:00 blueness Exp $

EAPI=4

inherit autotools eutils flag-o-matic

DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
MY_PV=${PV/_/-}
SRC_URI="http://www.torproject.org/dist/${PN}-${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-libs/openssl
	>=dev-libs/libevent-1.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_prepare() {
	epatch "${FILESDIR}"/torrc.sample-0.1.2.6.patch
	epatch "${FILESDIR}"/${PN}-0.2.1.19-logrotate.patch

	einfo "Regenerating autotools files ..."
	epatch "${FILESDIR}"/${PN}-0.2.1.30-respect-CFLAGS.patch
	eautoreconf

	# Normally tor uses a bundled libevent fragment to provide
	# asynchronous DNS requests.  This is generally a bad idea, but at
	# the moment the official libevent does not have the 0x20 hack, so
	# anonymity is higher with the bundled variant.  Remove patch as
	# soon as upstream has installed the autoconf option to use
	# system's libevent.  This hasn't happened, so we
	# have to live with the bundled libevent for this release, as the
	# current version in tree won't suffice for tor to build
	# See http://bugs.noreply.org/flyspray/index.php?do=details&id=920
	# for upstream's report
	# Let's revisit this when libevent-2* is unmasked
	# use bundledlibevent || epatch "${FILESDIR}"/${PN}-0.2.1.5-no-internal-libevent.patch
}

src_configure() {
	# Upstream isn't sure of all the user provided CFLAGS that
	# will break tor, but does recommend against -fstrict-aliasing.
	# We'll filter-flags them here as we encounter them.
	filter-flags -fstrict-aliasing
	econf $(use_enable debug)
}

src_install() {
	# allow the tor user more open files to avoid errors, see bug 251171
	newconfd "${FILESDIR}"/tor.confd tor

	newinitd "${FILESDIR}"/tor.initd-r6 tor
	emake DESTDIR="${D}" install
	keepdir /var/{lib,log,run}/tor

	dodoc README ChangeLog AUTHORS ReleaseNotes \
		doc/{HACKING,TODO}

	fperms 750 /var/lib/tor /var/log/tor
	fperms 755 /var/run/tor
	fowners tor:tor /var/lib/tor /var/log/tor /var/run/tor

	insinto /etc/tor/
	doins "${FILESDIR}"/torrc

	insinto /etc/logrotate.d
	newins contrib/tor.logrotate tor
}

pkg_postinst() {
	elog
	elog "We created a configuration file for tor, /etc/tor/torrc, but you can"
	elog "change it according to your needs.  Use the torrc.sample that is in"
	elog "that directory as a guide.  Also, to have privoxy work with tor"
	elog "just add the following line"
	elog
	elog "forward-socks4a / localhost:9050 ."
	elog
	elog "to /etc/privoxy/config.  Notice the . at the end!"
	elog
}
