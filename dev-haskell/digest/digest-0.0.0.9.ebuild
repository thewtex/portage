# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/digest/digest-0.0.0.9.ebuild,v 1.1 2011/08/01 21:36:29 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Various cryptographic hashes for bytestrings; CRC32 and Adler32 for now."
HOMEPAGE="http://hackage.haskell.org/package/digest"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2
		sys-libs/zlib"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
