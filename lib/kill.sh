#!/bin/sh

_kill() {
	_warn "Killing $1"
	kill -TERM $1
}

for _ARG in "$@"; do
	case "$_ARG" in
	-kill-all)
		for _EXISTING_APPLICATION_PIPE in $(find /tmp/$_APPLICATION_NAME -type p -not -name $$); do
			_kill $(basename $_EXISTING_APPLICATION_PIPE)
		done

		_exitSuccess "Killed"
		;;
	-kill=*)
		_kill ${_ARG#*=}

		_exitSuccess "Killed"
		;;
	esac
done
