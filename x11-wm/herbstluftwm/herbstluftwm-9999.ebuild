# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2

DESCRIPTION="Manual tiling window manager for X11 using Xlib and Glib"
HOMEPAGE="http://wwwcip.cs.fau.de/~re06huxa/herbstluftwm"
EGIT_REPO_URI="git://git.informatik.uni-erlangen.de/re06huxa/herbstluftwm"
EGIT_PROJECT="herbstluftwm"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc zsh-completion bash-completion"

DEPEND="app-text/asciidoc"
RDEPEND="${DEPEND}
		x11-libs/libX11"

src_install() {
	dobin ipc-client/herbstclient || die
	doman doc/herbstclient.1 \
		doc/herbstluftwm.1 || die

	insinto /etc/xdg/${PN}
	doins share/autostart \
		share/panel.sh \
		share/restartpanels.sh || die

	insinto /usr/share/${PN}
	doins -r scripts/ || die

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions/
		doins share/_herbstclient || die
	fi

	if use bash-completion; then
		insinto /etc/bash_completion.d/
		doins share/herbstclient-completion || die
	fi

	if use doc; then
		dodoc doc/herbstclient.html \
			doc/herbstluftwm.html || die
	fi
}


