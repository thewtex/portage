# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice-l10n/libreoffice-l10n-3.4.4.ebuild,v 1.1 2011/11/10 20:35:58 scarabeus Exp $

EAPI=4

[[ ${PV} == 9999 ]] && MY_PV="3.4.4" || MY_PV="${PV}"

RC_VERSION="rc2" # CHECK ME WITH EVERY BUMP!
BASE_SRC_URI="http://download.documentfoundation.org/${PN/-l10n/}/stable/${MY_PV}/rpm/"
inherit rpm eutils versionator

DESCRIPTION="Translations for the Libreoffice suite."
HOMEPAGE="http://www.libreoffice.org"

LICENSE="LGPL-3"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="offlinehelp"

LANGUAGES_HELP="bg bn bo bs ca_XV ca cs da de dz el en_GB en en_ZA eo es et eu
fi fr gl gu he hi hr hu id is it ja ka km ko mk nb ne nl nn om pl pt_BR pt ru si
sk sl sq sv tg tr ug uk vi zh_CN zh_TW"
LANGUAGES="${LANGUAGES_HELP} af ar as ast be br brx cy dgo fa ga gd kk kn kok ks
ku lo lt lv mai ml mn mni mr my nr nso oc or pa_IN ro rw sa_IN sat sd sh sr ss
st sw_TZ ta te th tn ts uz ve xh zu"

for lang in ${LANGUAGES}; do
	helppack=""
	langpack=""
	if [[ "${LANGUAGES_HELP}" =~ "${lang}" ]]; then
		[[ ${lang} == en ]] && lang2=${lang/en/en_US} || lang2=${lang}
		helppack=" offlinehelp? ( ${BASE_SRC_URI}/x86/LibO_${MY_PV}_Linux_x86_helppack-rpm_${lang2/_/-}.tar.gz ) "
	fi
	[[ ${lang} == en ]] \
		|| langpack=" ${BASE_SRC_URI}/x86/LibO_${MY_PV}_Linux_x86_langpack-rpm_${lang/_/-}.tar.gz "
	SRC_URI+=" linguas_${lang}? (
		${langpack}
		${helppack}
	)"
	IUSE+=" linguas_${lang}"
done
unset lang helppack langpack lang2

# dictionaries
SPELL_DICTS="af bg ca cs cy da de el en eo es et fr ga gl he hr hu it ku lt mk
nb nl nn pl pt ru sk sl sv tn zu"
for X in ${SPELL_DICTS} ; do
	SPELL_DICTS_DEPEND+=" linguas_${X}? ( app-dicts/myspell-${X} )"
done
RDEPEND="${SPELL_DICTS_DEPEND}"
unset X SPELL_DICTS SPELL_DICTS_DEPEND

# blockers for old libreoffice with linguas bundled
RDEPEND+="
	!<=app-office/libreoffice-3.4.3.2
	!=app-office/libreoffice-3.4.9999
	!=app-office/libreoffice-9999
	!<=app-office/libreoffice-bin-3.4.3-r1
"

RESTRICT="strip"

S="${WORKDIR}"

src_unpack() {
	default

	local lang dir rpmdir

	for lang in ${LANGUAGES}; do
		# break away if not enabled; paludis support
		use_if_iuse linguas_${lang} || continue

		dir=${lang/_/-}

		# for english we provide just helppack, as translation is always there
		if [[ ${lang} != en ]]; then
			rpmdir="LibO_${MY_PV}${RC_VERSION}_Linux_x86_langpack-rpm_${dir}/RPMS/"
			[[ -d ${rpmdir} ]] || die "Missing directory: \"${rpmdir}\""
			# First remove dictionaries, we want to use system ones.
			rm -rf "${S}/${rpmdir}/"*dict*.rpm
			rpm_unpack "./${rpmdir}/"*.rpm
		fi
		if [[ "${LANGUAGES_HELP}" =~ "${lang}" ]] && use offlinehelp; then
			[[ ${lang} == en ]] && dir="en-US"
			rpmdir="LibO_${MY_PV}${RC_VERSION}_Linux_x86_helppack-rpm_${dir}/RPMS/"
			[[ -d ${rpmdir} ]] || die "Missing directory: \"${rpmdir}\""
			rpm_unpack ./"${rpmdir}/"*.rpm
		fi
	done
}

src_prepare() { :; }
src_configure() { :; }
src_compile() { :; }

src_install() {
	local dir="${S}"/opt/${PN/-l10n/}$(get_version_component_range 1-2 ${MY_PV})/basis$(get_version_component_range 1-2 ${MY_PV})/
	# Condition required for people that do not install anything eg no linguas
	# or just english with no offlinehelp.
	if [[ -d "${dir}" ]] ; then
		if [[ ${PV} == 9999 ]]; then
			# Bump me when it gets slotted ; also do revision bump
			insinto /usr/$(get_libdir)/${PN/-l10n/}/basis3.5/
		else
			insinto /usr/$(get_libdir)/${PN/-l10n/}/basis$(get_version_component_range 1-2)/
		fi
		doins -r "${dir}"/*
	fi
}
