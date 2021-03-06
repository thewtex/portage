# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-3.0.2.ebuild,v 1.2 2011/11/28 05:45:54 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Varnish is a state-of-the-art, high-performance HTTP accelerator"
HOMEPAGE="http://www.varnish-cache.org/"
SRC_URI="http://repo.varnish-cache.org/source/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

#varnish compiles stuff at run time
RDEPEND="sys-devel/gcc"
DEPEND="dev-python/docutils"

RESTRICT="test" #315725

DOCS=( README doc/changes.rst )

src_install() {
	autotools-utils_src_install

	newinitd "${FILESDIR}"/varnishd.initd varnishd
	newconfd "${FILESDIR}"/varnishd.confd varnishd

	insinto /etc/logrotate.d
	newins "${FILESDIR}/varnishd.logrotate" varnishd

	dodir /var/log/varnish

	use doc && dohtml -r "doc/sphinx/=build/html/"
}

pkg_postinst () {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
}
