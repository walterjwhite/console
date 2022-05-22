#!/bin/sh

# automatically export assigned variables
set -a

_enable_debug() {
	set -x
}

for _ARG in "$@"; do
	case "$_ARG" in
	-d)
		_DEBUG=1

		# remove argument
		set -- $(echo $* | sed -e "s/-d//")

		;;
	esac
done

if [ -n "$_DEBUG" ]; then
	_enable_debug
fi
