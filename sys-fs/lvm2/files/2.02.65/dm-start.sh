# /lib/rcscripts/addons/dm-start.sh:  Setup DM volumes at boot

ebegin "Auto-detecting device-mapper volumes"
/sbin/dmsetup mknodes
eend 0

# vim:ts=4
