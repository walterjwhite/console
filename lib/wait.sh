#!/bin/sh

_RUNNING=1
_CLEANED=0

_on_exit() {
	_RUNNING=0
	if [ $_CLEANED -eq 0 ]; then
		_cleanup
	fi

	_CLEANED=1

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

	_APPLICATION_PIPE=/tmp/$_APPLICATION_NAME/$(basename $0)/$$
	_APPLICATION_PIPE_DIR=$(dirname $_APPLICATION_PIPE)

	mkdir -p $_APPLICATION_PIPE_DIR
	mkfifo $_APPLICATION_PIPE
}

_waitee_done() {
	if [ -n "$_WAITEE" ]; then
		_info "$0 process completed, notifying"

		echo "done" >$_APPLICATION_PIPE

		_info "$0 downstream process picked up"
	fi

	rm -f $_APPLICATION_PIPE
}

_waiter() {
	_UPSTREAM_APPLICATION_PIPE=$(find /tmp -type p -name $1 2>/dev/null | head -1)

	if [ -z "$_UPSTREAM_APPLICATION_PIPE" ]; then
		_exit_with_error "$1 not found" 1
	fi

	if [ ! -e $_UPSTREAM_APPLICATION_PIPE ]; then
		_warn "$_UPSTREAM_APPLICATION_PIPE does not exist, did upstream start?"
		return
	fi

	_require "$_CONF_WAIT_INTERVAL" _CONF_WAIT_INTERVAL 1

	_info "Waiting for upstream to complete: $1"

	# attempt to read from the pipe
	while [ 1 ]; do
		timeout $_CONF_WAIT_INTERVAL cat $_UPSTREAM_APPLICATION_PIPE >/dev/null 2>&1
		local _UPSTREAM_STATUS=$?
		if [ $_UPSTREAM_STATUS -eq 0 ]; then
			_warn "Upstream finished: $_UPSTREAM_APPLICATION_PIPE ($_UPSTREAM_STATUS)"
			break
		fi

		_info " Upstream is still running: $_UPSTREAM_APPLICATION_PIPE ($_UPSTREAM_STATUS)"
	done
}

if [ $# -gt 0 ]; then
	case $1 in
	-w=*)
		_waiter "${1#*=}"
		shift
		;;
	-w)
		_WAITEE=1
		shift
		;;
	esac
fi

# https://phoenixnap.com/kb/bash-trap-command
trap _on_exit INT 0 1 2 3 4 15

# always open the pipe so we can easily identify processes later
_waitee_start
