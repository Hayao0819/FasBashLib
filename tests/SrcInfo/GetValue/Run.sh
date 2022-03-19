# shellcheck disable=SC2148,SC2034

readarray -t SrcInfo << EOF
pkgbase = alterlinux-live-tools
	pkgdesc = Scripts required for live environment
	pkgver = 1.9
	pkgrel = 1
	url = https://github.com/FascodeNet/fascode-live-tools
	arch = any
	license = SUSHI-WARE
	depends = xdg-user-dirs
	depends = bash
	source = https://github.com/FascodeNet/fascode-live-tools/archive/v1.9.zip
	md5sums = ac0c2a9c7c8e34d4a7afe9f6f5f4260d

pkgname = alterlinux-live-tools
	pkgdesc = Scripts required for live environment (meta package)
	depends = xdg-user-dirs
	depends = bash
	depends = alterlinux-live-tools
	depends = fascode-gtk-bookmarks
	depends = alterlinux-welcome-page
	depends = alterlinux-plasma-bookmarks
	depends = alterlinux-desktop-file
	depends = alterlinux-live-info
	depends = alterlinux-gtk-bookmarks

pkgname = fascode-gtk-bookmarks
	pkgdesc = Simple script to automatically generate GTK bookmarks
	provides = alterlinux-gtk-bookmarks
	replaces = alterlinux-gtk-bookmarks

pkgname = alterlinux-welcome-page
	pkgdesc = A simple script to open the official AlterLinux website
	optdepends = chromium: To open the page
	optdepends = google-chrome: To open the page
	optdepends = firefox: To open the page

pkgname = alterlinux-plasma-bookmarks
	pkgdesc = Simple script to automatically generate Plasma bookmarks

pkgname = alterlinux-desktop-file
	pkgdesc = Place the Calamares icon on your desktop
	depends = xdg-user-dirs
	depends = bash
	depends = glib2

pkgname = alterlinux-live-info
	pkgdesc = Display version information of live environment

pkgname = alterlinux-gtk-bookmarks
	pkgdesc = Simple script to automatically generate GTK bookmarks
	depends = fascode-gtk-bookmarks
EOF


PrintEvalArray SrcInfo | SrcInfo.GetValue "pkgver"
PrintEvalArray SrcInfo | SrcInfo.GetValue "pkgdesc" "alterlinux-gtk-bookmarks"
PrintEvalArray SrcInfo | SrcInfo.GetValue "pkgdesc" "alterlinux-live-info"
PrintEvalArray SrcInfo | SrcInfo.GetValue "source" "alterlinux-gtk-bookmarks" "i686"
PrintEvalArray SrcInfo | SrcInfo.GetValue "md5sums" "alterlinux-gtk-bookmarks" "any"
