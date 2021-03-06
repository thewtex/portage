# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-1.0.ebuild,v 1.1 2011/11/30 21:03:33 fuzzyray Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"
PYTHON_USE_WITH="readline"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python

DESCRIPTION="Replacement for 'emerge --search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="mirror://github/fuzzyray/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="linguas_fr linguas_it"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"

DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}"

distutils_src_compile_pre_hook() {
	echo VERSION="${PVR}" "$(PYTHON)" setup.py set_version
	VERSION="${PVR}" "$(PYTHON)" setup.py set_version \
		|| die "setup.py set_version failed"
}

src_compile() {
	distutils_src_compile
}

src_install() {
	python_convert_shebangs -r "" build-*/scripts-*
	distutils_src_install
	dodoc eupdatedb.cron || die "dodoc failed"

	# Remove unused man pages according to the linguas flags
	if ! use linguas_fr ; then
		rm -rf "${ED}"/usr/share/man/fr
	fi

	if ! use linguas_it ; then
		rm -rf "${ED}"/usr/share/man/it
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	ewarn "Because file locations have changed, please run 'hash -r' in your active shells."
}
