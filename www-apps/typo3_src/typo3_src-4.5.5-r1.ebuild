# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils webapp depend.php

DESCRIPTION="TYPO3 is a free Open Source CMS. This is the source package."
HOMEPAGE="http://typo3.org/"
SRC_URI="mirror://sourceforge/typo3/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="mysql"

RDEPEND="~www-apps/typo3_dummy-${PV}
	|| ( >=dev-lang/php-5.3[truetype,zlib,mysql] >=dev-lang/php-5.3[truetype,zlib,mysqli] )
	|| ( media-gfx/graphicsmagick[zlib,truetype,tiff,png,jpeg] <=media-gfx/imagemagick-4.2.9[zlib,truetype,tiff,png,jpeg] )"

need_php5_httpd

pkg_setup() {
	local optional="truetype zlib"
	if ! PHPCHECKNODIE="yes" require_php_with_use ${optional} || \
		! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
		    ewarn
		    ewarn "NOTE: The above use flags are not enabled for your PHP install"
		    ewarn "but are strongly recommended to make use of full features of ${PN}."
		    ewarn "Consider re-emerging ${PHP_PKG} with those USE flags enabled."
		    ewarn
		    ebeep
		    epause 5
	fi

	# check for mysql support first, this is the preferred and primary DB backend
	if use mysql ; then
		require_php_with_use mysql
	else
		# check for at least one of DB backends supported by the bundled ADOdb
		local adodb="db2 firebird interbase mssql mysql mysqli oci8 odbc pdo postgres sapdb sqlite sybase"
		ewarn
		ewarn "MySQL is the recommended DB backend for ${PN} but you do not have USE=mysql"
		ewarn "enabled for PHP. Support for other DB backends is provided via ADOdb abstraction"
		ewarn "and includes:"
		ewarn "${adodb}"
		ewarn
		ebeep
		epause 5
		require_php_with_any_use ${adodb}
	fi

	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	rm -f {GPL,LICENSE}.txt
	dodoc *.txt ChangeLog
	rm -f *.txt ChangeLog
	
	insinto "${MY_HTDOCSDIR}"
	dodir "${MY_HTDOCSDIR}"
	
	cp -R . "${D}"/"${MY_HTDOCSDIR}"
	
	local files="typo3/ext"
	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}

pkg_postinst() {
	elog
	elog "Some sort of PHP cache is highly recommended for ${PN}."
	elog "If you have not installed one yet, consider emerging one of the following ebuilds:"
	elog "		dev-php/xcache"
	elog "		dev-php/eaccelerator"
	elog "		dev-php/pecl-apc"
	elog
	elog "TYPO3 is divided into two corresponding packages: One containing"
	elog "the core (www-apps/typo3_src) and a second one, containing necessary"
	elog "files to get a fresh instance running (www-apps/typo3_dummy)."
	elog "Every time, a new version of TYPO3 core is released, it's dummy"
	elog "package is updated, too. Most of the time containing only an updated"
	elog "changelog. But it might also happen that other files are updated"
	elog "within the dummy package. Therefore, the recommended upgrade"
	elog "procedure suggests to always update both packages at the same time"
	elog "before continuing with TYPO3's official upgrade instructions [1]."
	elog
	elog "The official dummy package contains a symlink named \"typo3_src\","
	elog "pointing to \"../typo3_src-VERSION\" and further ones, such as"
	elog "\"t3lib\" or \"typo3\", pointing to that symlink. That way, if there's"
	elog "an update, the only directory that must be changed is the one where"
	elog "the \"typo3_src\" symlink points to."
	elog "The www-apps/typo3_dummy ebuild removes that symlink, since Funtoo's"
	elog "webapp-config mechanism is more effective. So the \"Funtoo way\" to"
	elog "setup TYPO3 is to first install one or more instances of"
	elog "www-apps/typo3_dummy using webapp-config as by the following"
	elog "example:"
	elog
	elog "webapp-config -I -h ${VHOST_HOSTNAME} -d typo3 typo3_dummy ${PVR}"
	elog
	elog "After the www-apps/typo3_dummy package has been installed that way,"
	elog "the package www-apps/typo3_src package must be installed into the"
	elog "same directory as a subfolder called \"typo3_src\" as by the following"
	elog "example (this assumes that you used the directory \"typo3\" as"
	elog "destination for the dummy package):"
	elog
	elog "webapp-config -I -h ${VHOST_HOSTNAME} -d typo3/${PN} ${PN} ${PVR}"
	elog
	elog "After this you can start using TYPO3 as usual."
	elog
	elog "If you have set USE=\"vhosts\", webapp-config will install the two"
	elog "packages based on it's defaults at these two locations:"
	elog
	elog "/var/www/${VHOST_HOSTNAME}/htdocs/${PN}"
	elog "and"
	elog "/var/www/${VHOST_HOSTNAME}/htdocs/typo3_dummy"
	elog
	elog "You have to set a symlink pointing from"
	elog "/var/www/${VHOST_HOSTNAME}/htdocs/typo3_dummy/${PN}"
	elog "to"
	elog "/var/www/${VHOST_HOSTNAME}/htdocs/${PN}"
	elog "manually in this case (or wherever your defaults point to)."
	elog
	elog "[1] http://wiki.typo3.org/wiki/Upgrade"
	elog
	webapp_pkg_postinst
}
