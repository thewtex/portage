# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.3.ebuild,v 1.13 2010/01/15 17:45:58 grobian Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-solaris"
IUSE=""

RDEPEND="dev-java/tomcat-servlet-api:${SLOT}"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT}"
