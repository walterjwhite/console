#!/bin/sh

# automatically export assigned variables
set -a

_enable_debug() {
	set -x
}

if [ $# -gt 0 ]; then
	case $1 in
	-d)
		_DEBUG=1
		shift
		;;
	esac
fi

if [ -n "$_DEBUG" ]; then
	_enable_debug
fi
