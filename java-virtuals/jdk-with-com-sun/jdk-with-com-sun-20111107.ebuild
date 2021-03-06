# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jdk-with-com-sun/jdk-with-com-sun-20111107.ebuild,v 1.1 2011/11/07 16:08:10 caster Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from a JDK"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/icedtea-bin:6
			dev-java/icedtea:6
			dev-java/sun-jdk:1.6
			dev-java/sun-jdk:1.5
			dev-java/sun-jdk:1.4
			dev-java/oracle-jdk-bin:1.7
			dev-java/diablo-jdk:1.6
		)"

JAVA_VIRTUAL_VM="icedtea-bin-6 icedtea6-bin icedtea-6 icedtea6 icedtea-bin-6 sun-jdk-1.6 sun-jdk-1.5 sun-jdk-1.4 oracle-jdk-bin-1.7 diablo-jdk-1.6"
