#!/bin/sh

_require_file() {
	if [ ! -e $1 ]; then
		if [ $# -eq 2 ]; then
			_warn "$1 does not exist"
			return 1
		fi

		_exitWithError "$1 does not exist" 1
	fi
}
