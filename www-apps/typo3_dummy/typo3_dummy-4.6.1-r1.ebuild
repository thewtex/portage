# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit webapp

MY_PN="dummy"
DESCRIPTION="TYPO3 is a free Open Source CMS. This is the dummy package."
HOMEPAGE="http://typo3.org/"
SRC_URI="mirror://sourceforge/typo3/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

PDEPEND="~www-apps/typo3_src-${PV}"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f typo3_src
}

src_install() {
	webapp_src_preinst
	dodoc *.txt

	cp -R . "${D}"/${MY_HTDOCSDIR}

local files="fileadmin fileadmin/_temp_ fileadmin/user_upload typo3temp uploads uploads/pics uploads/media uploads/tf typo3conf typo3conf/extTables.php typo3conf/localconf.php typo3conf/ext typo3conf/l10n"
	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_configfile ${MY_HTDOCSDIR}/typo3conf/localconf.php
	webapp_src_install
}
