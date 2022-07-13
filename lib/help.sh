#!/bin/sh

_print_help() {
	if [ -e $1 ]; then
		cat $1
		echo ""
	fi
}

if [ $# -gt 0 ]; then
	case $1 in
	-h | --help)
		_print_help _LIBRARY_PATH_/_APPLICATION_NAME_/help/default
		_print_help _LIBRARY_PATH_/$_APPLICATION_NAME/help/$(basename $0)

		exit 0
		;;
	esac
fi
