# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/zip-archive/zip-archive-0.1.1.6.ebuild,v 1.11 2011/04/24 13:56:57 mr_bones_ Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Library for creating and modifying zip archives."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/zip-archive"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		dev-haskell/binary
		>=dev-haskell/cabal-1.2
		>=dev-haskell/digest-0.0.0.1
		dev-haskell/mtl
		>=dev-haskell/utf8-string-0.3.1
		dev-haskell/zlib"
DEPEND="${RDEPEND}"
