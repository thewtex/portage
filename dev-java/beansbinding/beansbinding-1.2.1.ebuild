# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/beansbinding/beansbinding-1.2.1.ebuild,v 1.1 2008/11/16 16:28:28 fordfrog Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementation of JSR295."
HOMEPAGE="https://beansbinding.dev.java.net"
SRC_URI="https://beansbinding.dev.java.net/files/documents/6779/73673/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

S="${WORKDIR}"

src_install() {
	java-pkg_dojar "dist/${PN}.jar"
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*
}

