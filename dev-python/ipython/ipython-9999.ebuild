# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.10.ebuild,v 1.9 2009/11/11 00:06:28 ranger Exp $

EAPI="3"

EBZR_REPO_URI="lp:ipython"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils elisp-common bzr

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/"
#SRC_URI="http://ipython.scipy.org/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc emacs examples gnuplot readline smp test wxwidgets"

CDEPEND="dev-python/pexpect
	wxwidgets? ( dev-python/wxpython )
	readline? ( sys-libs/readline )
	emacs? ( app-emacs/python-mode virtual/emacs )
	smp? (  net-zope/zope-interface
			dev-python/foolscap
			dev-python/pyopenssl )"
RDEPEND="${CDEPEND}
	gnuplot? ( dev-python/gnuplot-py )"
DEPEND="${CDEPEND}
	test? ( dev-python/nose )"

RESTRICT_PYTHON_ABIS="3*"

PYTHON_MODNAME="IPython"
SITEFILE="62ipython-gentoo.el"

src_prepare() {
	sed -i \
		-e "s:share/doc/ipython:share/doc/${PF}:" \
		setupbase.py || die "sed failed"
	if ! use doc; then
		sed -i \
			-e '/extensions/d' \
			-e 's/+ manual_files//' \
			setupbase.py || die "sed failed"
	fi
	if ! use examples; then
		sed -i \
			-e 's/+ example_files//' \
			setupbase.py || die "sed failed"
	fi
}

src_compile() {
	distutils_src_compile
	if use emacs; then
		elisp-compile docs/emacs/ipython.el || die "elisp-compile failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --home="${WORKDIR}/test-${PYTHON_ABI}" > /dev/null || die "Installation of tests failed with Python ${PYTHON_ABI}"
		pushd "${WORKDIR}/test-${PYTHON_ABI}" > /dev/null || die
		# First initialize .ipython stuff.
		PATH="${WORKDIR}/test-${PYTHON_ABI}/bin:${PATH}" PYTHONPATH="${WORKDIR}/test-${PYTHON_ABI}/lib/python" ipython > /dev/null <<-EOF
		EOF
		# Test (-v for more verbosity).
		PATH="${WORKDIR}/test-${PYTHON_ABI}/bin:${PATH}" PYTHONPATH="${WORKDIR}/test-${PYTHON_ABI}/lib/python" iptest
		popd > /dev/null || die
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use emacs; then
		pushd docs/emacs
		elisp-install ${PN} ${PN}.el* || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		popd
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
