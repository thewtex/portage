# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit autotools eutils games

DESCRIPTION="Satirical console-based political role-playing/strategy game"
HOMEPAGE="http://sourceforge.net/projects/lcsgame/"
SRC_URI="mirror://sourceforge/lcsgame/lcs_${PV}_src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="sys-libs/ncurses"

dir="${GAMES_DATADIR}"/"${PN}"

src_unpack() {
	unpack "${A}"
	cd "${WORKDIR}"/lcs_"${PV}"_src || die "failed to enter work directory"
	# workaround for directory not being named ${P}
	S="$(pwd)"
	einfo "Setting WORKDIR to ${S}"
}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf
}

src_install() {
	# The game has trouble loading data from other directories. This seems
	# to be fixed in the live build, so the next stable release will likely
	# not need this dirty workaround. Unmask lcs-9999 if you want to try it.
	exeinto "${dir}"
	doexe src/crimesquad || die
	games_make_wrapper "crimesquad" "${dir}/crimesquad" "${dir}" || die
	insinto "${dir}"/art
	doins -r art/* || die
	doman man/crimesquad.6 || die
	dodoc AUTHORS ChangeLog LINUX_README.txt NEWS docs/CrimeSquadManual.txt || die
	if use doc; then
		 dodoc docs/cpcimageformat.txt docs/conventions.txt || die
	fi

	prepgamesdirs
}

pkg_postinst() {
	einfo "Since this game was originally coded for DOS, it has a screen"
	einfo "size of 80x25, whereas the default size of a typical terminal"
	einfo "emulator is 80x24. This may result in the last row of the"
	einfo "display being misplaced. Increase the size of your terminal by"
	einfo "one row to rectify this."
}
