# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-liquid/ruby-liquid-2.2.2.ebuild,v 1.2 2011/02/14 06:51:59 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

# Drop tests and documentation tasks for 2.1.2 since they are no
# longer included in the gem, and github is not tagged and it's not
# obvious how it matches the released gem version.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.md"

RUBY_FAKEGEM_NAME="liquid"

inherit ruby-fakegem

DESCRIPTION="Template engine for Ruby"
HOMEPAGE="http://www.liquidmarkup.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd ~x86"
IUSE=""
