#!/bin/sh

_require_file() {
	if [ ! -e $1 ]; then
		_exitWithError "$1 does not exist" 1
	fi
}
