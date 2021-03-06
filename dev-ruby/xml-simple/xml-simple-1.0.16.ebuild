# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xml-simple/xml-simple-1.0.16.ebuild,v 1.3 2011/10/17 22:13:08 hwoarang Exp $

EAPI=2
USE_RUBY="ruby18 jruby ree18"

# Gem only contains lib code, and no easily accessible upstream repository.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Easy API to maintain XML. It is a Ruby port of Grant McLean's Perl module XML::Simple."
HOMEPAGE="http://rubyforge.org/projects/xml-simple/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~x86"
IUSE=""
