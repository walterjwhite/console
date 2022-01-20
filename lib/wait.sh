#!/bin/sh

_on_exit() {
	_cleanup

	_waitee_done
}

# to be overridden as required
_cleanup() {
	:
}

_waitee_start() {
	_warn "Please use $$ (-w=$$) for the downstream process"
	mkfifo /tmp/$$

	_WAITEE=1
}

_waitee_done() {
	if [ -n "$_WAITEE" ]; then
		_info "$0 process completed, notifying"

		### TODO: to use a timeout here or not
		echo "done" >/tmp/$$

		_info "$0 downstream process picked up"
	fi
}

_waiter() {
	if [ ! -e /tmp/$1 ]; then
		_warn "/tmp/$1 does not exist, did upstream start?"
		return
	fi

	# attempt to read from the pipe
	cat /tmp/$1 >/dev/null 2>&1

	# remove pipe
	rm -f /tmp/$1
}

trap _on_exit INT 0 1 2 3 4

for _ARG in "$@"; do
	case "$_ARG" in
	-w=*)
		_waiter "${_ARG#*=}"
		shift
		;;
	-w)
		_waitee_start
		shift
		;;
	esac
done
