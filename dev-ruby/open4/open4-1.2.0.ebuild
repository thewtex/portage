# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/open4/open4-1.2.0.ebuild,v 1.1 2011/10/05 06:23:29 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Open3::popen3 with exit status"
HOMEPAGE="http://rubyforge.org/projects/codeforpeople/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"

all_ruby_prepare () {
	mv rakefile Rakefile || die
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/samples
	doins samples/*
}
