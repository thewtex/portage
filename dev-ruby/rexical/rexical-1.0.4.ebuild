# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rexical/rexical-1.0.4.ebuild,v 1.3 2010/01/15 15:41:37 ranger Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc	DOCUMENTATION.en.rdoc  DOCUMENTATION.ja.rdoc  README.ja  README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Rexical is a lexical scanner generator"
HOMEPAGE="http://github.com/tenderlove/rexical/tree/master"
LICENSE="LGPL-2" # plus exception

KEYWORDS="~amd64 ~ppc ~ppc64"
SLOT="0"
IUSE=""

ruby_add_bdepend doc "dev-ruby/hoe"
ruby_add_bdepend test "dev-ruby/hoe virtual/ruby-test-unit"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-ruby187.patch
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc sample/* || die
}
