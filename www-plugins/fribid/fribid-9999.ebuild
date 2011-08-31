
EAPI=3

inherit eutils git

DESCRIPTION="A browser plugin to manage Swedish BankID:s"
HOMEPAGE="http://fribid.se"

EGIT_REPO_URI="git://github.com/samuellb/fribid.git"
SRC_URI=""

S="${WORKDIR}/${PN}"

LICENSE="MIT MPL GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~mips ~sparc"
IUSE="smartcard pkcs11 dev"

DEPEND=">=dev-libs/openssl-0.9.8
		>=dev-libs/libp11-0.2.7
		>=x11-libs/gtk+-2.24
		smartcard? ( >=sys-apps/pcsc-lite-1.6.1 )
		dev? ( >=dev-libs/opensc-0.11.13 )
		pkcs11? ( >=dev-libs/engine_pkcs11-0.1.8 )"
RDEPEND="${DEPEND}"

src_configure() {
	fribidconf=""
	if use pkcs11 ; then
		fribidconf="
		--pkcs11-engine=/usr/lib/engines/engine_pkcs11.so
		--enable-pkcs11"
	fi
	./configure \
		--prefix=/usr \
		${fribidconf} \
		--disable-pkcs11 \
		--datadir=/usr/share \
		--prefix=/usr \
		--plugin-path=/usr/lib/nsbrowser/plugins || die
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGELOG || die
}

pkg_postinst() {
	if use dev ; then
		sed -i -e "s|^# enable_pinpad = true|enable_pinpad = true|" \
			/etc/opensc/opensc.conf
	fi
	chmod +x /usr/lib/fribid/libfribidplugin.so
	elog "Congratulations! FriBID was successfully installed"
}
