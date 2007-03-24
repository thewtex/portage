# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A frontend for ClamAV using Gtk2-perl."
HOMEPAGE="http://clamtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="~x86"

LANGS="cs da de es fr it pl pt_BR ru zh_CN"
IUSE="nls"
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done

DEPEND=""
RDEPEND="dev-perl/gtk2-perl
	dev-perl/File-Find-Rule
	dev-perl/libwww-perl
	dev-perl/Date-Calc
	app-antivirus/clamav
	nls? ( dev-perl/Locale-gettext )"


src_install() {
	dobin clamtk

	doicon ${PN}.png
	domenu ${PN}.desktop

	dodoc CHANGES DISCLAIMER README
	doman ${PN}.1.gz

	if use nls ; then
		cd po/
		mv cs_CZ.mo cs.mo
		for n in *.mo ; do
			if use linguas_${n/.mo} ; then
				insinto /usr/share/locale/${n/.mo}/LC_MESSAGES
				newins ${n} ${PN}.mo
			fi
		done
	fi
}
