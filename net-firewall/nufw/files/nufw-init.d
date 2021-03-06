#!/sbin/runscript

depend() {
	before net
}

start() {
	ebegin "Starting nufw"
	start-stop-daemon --start --quiet --exec /usr/sbin/nufw -- -D ${NUFW_OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping nufw"
	start-stop-daemon --stop --quiet --pidfile /var/run/nufw.pid
	eend $?
}
