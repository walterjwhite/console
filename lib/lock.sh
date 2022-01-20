#!/bin/sh

# NOTE: if a global lock is needed, overwrite value in child script
# _LOCKFILE=/tmp/$(basename $0).lock
_LOCKFILE=/tmp/$(whoami)/$(basename $0).lock

# if > 0, wait, else fail immediately
_LOCK_TIMEOUT=0

_runOne() {
	mkdir -p $(dirname $_LOCKFILE)

	(
		if [ $_LOCK_TIMEOUT -gt 0 ]; then
			flock -w $_LOCK_TIMEOUT 9 || exit 6
		else
			flock -n 9 || exit 6
		fi

		_unsafe
	) 9>$_LOCKFILE
}
