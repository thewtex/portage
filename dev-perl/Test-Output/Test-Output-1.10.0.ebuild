# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Output/Test-Output-1.10.0.ebuild,v 1.3 2011/11/06 17:35:32 maekke Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Utilities to test STDOUT and STDERR messages"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Sub-Exporter
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Tester-0.107
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
