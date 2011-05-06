# Copyright 1999-2010 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

if [ ${PV} == "9998" -o ${PV} == "9999" ] ; then
	
	if [ ${PV} == "9998" ] ; then
		if [ -z ${ONLY_FOR_FUNTOO_DEVS} ]; then
			die "Release only for Funtoo devs, please define ONLY_FOR_FUNTOO_DEVS prior emerging this package if you wish to test it"
		else
			EGIT_REPO_URI="git://github.com/adessemond/pxz.git"
		fi
	else
		EGIT_REPO_URI="git://github.com/jnovy/pxz.git"
	fi

	SRC_URI=""
	inherit git
else
	# Remove a possible -Wl,--as-needed statement, pxz 4.9.999.9 is known to crash at build time with that option active.
	LDFLAGS="${LDFLAGS/-Wl,--as-needed}"
	MY_P="${PN}-${PV/_}"
	SRC_URI="http://jnovy.fedorapeople.org/pxz/${MY_P}.20091201git.tar.xz -> ${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~sparc ~x86"
	S=${WORKDIR}/${MY_P}
fi

inherit eutils

DESCRIPTION="Parallel LZMA compressor/decompressor"
HOMEPAGE="http://jnovy.fedorapeople.org/pxz"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND=">=app-arch/xz-utils-4.999.9_beta"
DEPEND="${RDEPEND}"

src_install() {
	# Do not remove DESTDIR="${D}", else the package will try copy some files in /usr/bin resulting in a sandbox violation 
	emake install DESTDIR="${D}" || die
	#rm "${D}"/usr/share/doc/xz/COPYING* || die
	#mv "${D}"/usr/share/doc/{xz,${PF}} || die
	#prepalldocs
	#dodoc AUTHORS ChangeLog NEWS README THANKS
}
