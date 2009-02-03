# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools versionator

MY_PN=$(echo ${PN%-*})
MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="The world's most popular open source database."
HOMEPAGE="http://dev.mysql.com/doc/refman/6.0/en/mysql-nutshell.html"
SRC_URI="http://mirrors.24-7-solutions.net/pub/mysql/Downloads/MySQL-6.0/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"

IUSE="+utf8 -doc +community +ssl -tcpwrapper +libevent -innodb +falcon -federated -maria -cluster -test"

FEATURES="strict sandbox collision-protect"

DEPEND="
    sys-apps/gawk
    sys-libs/ncurses
    sys-libs/zlib
    doc? ( app-doc/doxygen
           dev-texlive/texlive-latex
           app-text/texlive-core )
    dev-lang/perl
    tcpwrapper? ( sys-apps/tcp-wrappers )"

RDEPEND="${DEPEND}"

MY_DIRCONF="/etc/mysql"
MY_DIRLIB="/var/lib/mysql"
MY_DIRRUN="/var/run/mysqld"
MY_DIRRUN_PID="/var/run/mysqld/mysqld.pid"
MY_DIRRUN_SOCKET="/var/run/mysqld/mysqld.sock"
MY_DIRLOG="/var/log/mysql"

S="${MY_PN}-${MY_PV}"

src_unpack() {
    unpack ${A}
    cd "${S}"

    if ! use test ; then
        epatch "${FILESDIR}/${PV}/patches/disable-test-cases.patch"
    fi

    eautoreconf || die "eautoreconf failed"
}

src_compile() {
    local myconf
    local myplugins

    if use utf8 ; then
        myconf="${myconf} --with-charset=utf8"
    fi

    if ! use doc ; then
        myconf="${myconf} --without-docs --without-man"
    fi

    if ! use community ; then
        myconf="${myconf} --disable-community-features"
    fi

    # This uses YaSSL by default.
    if use ssl ; then
        myconf="${myconf} --with-ssl"
    fi

    if use tcpwrapper ; then
        myconf="${myconf} --with-libwrap"
    fi

    if use libevent ; then
        myconf="${myconf} --with-libevent"
    fi

    if use innodb ; then
        myplugins="${myplugins},innobase"
    fi

    if use falcon ; then
        myplugins="${myplugins},falcon"
    fi

    if use federated ; then
        myplugins="${myplugins},federated"
    fi

    if use maria ; then
        myplugins="${myplugins},maria"
    fi

    if use cluster ; then
        myplugins="${myplugins},ndbcluster"
    fi

    cd "${S}"
    econf ${myconf} --with-plugins=${myplugins} || die "configure failed"

    emake || die "make failed"
}

src_test() {
    make check || die "make check failed"
}

src_install() {
    cd "${S}"

    emake DESTDIR="${D}" install || die "install failed"

    if use doc ; then
        dodoc "${FILESDIR}/${PV}/docs/readme" || die "dodoc failed"
    fi

    keepdir "${ROOT}${MY_DIRLIB}"
    keepdir "${ROOT}${MY_DIRRUN}"
    keepdir "${ROOT}${MY_DIRLOG}"

    dodir "${ROOT}${MY_DIRCONF}"
    insinto "${ROOT}${MY_DIRCONF}"
    doins "${FILESDIR}/${PV}/config/"*.cnf
    newins "${FILESDIR}/${PV}/config/"my.cnf my.cnf-bak

    newinitd "${FILESDIR}/${PV}/init/mysqld" mysqld
}

pkg_preinst() {
    enewgroup mysql
    enewuser mysql -1 -1 -1 mysql
}

pkg_postinst() {
    chown -R mysql:mysql "${ROOT}${MY_DIRLIB}"
    chown -R mysql:mysql "${ROOT}${MY_DIRRUN}"
    chown -R mysql:mysql "${ROOT}${MY_DIRLOG}"

    chmod -R 660 "${ROOT}${MY_DIRLOG}"
    chmod 775 "${ROOT}${MY_DIRLOG}"

    ewarn "This is alpha software; report bugs upstream."
    ewarn ""

    elog "If this is your first time installing please do:"
    elog ""
    elog "emerge -va dev-db/mysql-community --config"
}

pkg_config() {
    if [ ! -d /var/lib/mysql/mysql ] ; then
        local password1="a"
        local password2="b"
        local retries="3"

        einfo "Input a password for the mysql 'root' user (avoid [\"'\\_%] characters):"
        read -rsp "   >" password1 ; echo

        einfo "Retype the password:"
        read -rsp "   >" password2 ; echo

        einfo "Verifying passwords ..."
        if [[ "x$password1" == "x$password2" ]] ; then
            einfo "    ... done!"
        else
            die "    ... passwords are not the same!"
        fi

        einfo "Creating the database ..."
        mysql_install_db > /dev/null 2>&1
        einfo "    ... done."

        einfo "Verifying existence of the mysql 'root' user ..."

        if [[ $(grep -a -o -e '.*root' /var/lib/mysql/mysql/user.MYD | wc -l) -gt 0 ]] ; then
            einfo "    ... done!"
        else
            die "    ... user does not exist!"
        fi

        einfo "Cleaning up ..."
        start-stop-daemon --stop --quiet --pidfile="${MY_DIRRUN_PID}" > /dev/null 2>&1
        einfo "    ... done!"

        einfo "Temporarily starting the mysql server ..."
        mysqld_safe > /dev/null 2>&1 &

        while ! [[ -S "${socket}" || "${retries}" -lt 1 ]] ; do
            retries=$(( ${retries} - 1 ))
            sleep 3
        done

        einfo "    ... done!"

        einfo "Setting the root password ..."
        mysqladmin -u root password ${password1}
        einfo "    ... done!"

        einfo "Cleaning up ..."
        start-stop-daemon --stop --quiet --pidfile="${MY_DIRRUN_PID}" > /dev/null 2>&1
        einfo "    ... done!"

        einfo ""
        einfo "To run the server do:"
        einfo ""
        einfo "eselect rc start mysqld"
    else
        einfo "You already have the mysql database in place. If you are having"
        einfo "problems trying to start mysqld, check your config file(s)"
        einfo "and/or database(s) and/or logfile(s)."
    fi
}
