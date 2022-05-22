#!/bin/sh

_RUNNING=1

_on_exit() {
	_RUNNING=0
	_cleanup

	_waitee_done

	# kill any backgrounded jobs
	exit $1
}

# to be overridden as required
_cleanup() {
	:
}

_waitee_start() {
	if [ -n "$_WAITEE" ]; then
		_warn "Please use $$ (-w=$$) for the downstream process"
	fi

	_APPLICATION_PIPE=/tmp/$_APPLICATION_NAME/$$

	mkdir -p $(dirname $_APPLICATION_PIPE)
	mkfifo $_APPLICATION_PIPE
}

_waitee_done() {
	if [ -n "$_WAITEE" ]; then
		_info "$0 process completed, notifying"

		### TODO: to use a timeout here or not
		echo "done" >$_APPLICATION_PIPE

		_info "$0 downstream process picked up"
	fi

	rm -f $_APPLICATION_PIPE
}

_waiter() {
	_APPLICATION_PIPE=$(find /tmp -type p -name $1 | head -1)

	if [ -z "$_APPLICATION_PIPE" ]; then
		_exitWithError "$_APPLICATION_PIPE not found" 1
	fi

	if [ ! -e $_APPLICATION_PIPE ]; then
		_warn "$_APPLICATION_PIPE does not exist, did upstream start?"
		return
	fi

	# attempt to read from the pipe
	cat $_APPLICATION_PIPE >/dev/null 2>&1

	# remove pipe
	rm -f $_APPLICATION_PIPE
}

# https://phoenixnap.com/kb/bash-trap-command
trap _on_exit INT 0 1 2 3 4 15

for _ARG in "$@"; do
	case "$_ARG" in
	-w=*)
		_waiter "${_ARG#*=}"

		set -- $(echo $* | sed -e "s/$_ARG//")
		;;
	-w)
		set -- $(echo $* | sed -e "s/-w//")
		_WAITEE=1
		;;
	esac
done

# always open the pipe so we can easily identify processes later
_waitee_start
