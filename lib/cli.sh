#!/bin/sh

for _ARG in "$@"; do
	case "$_ARG" in
	-d | --debug)
		_enable_debug

		# remove argument
		shift

		;;
	-h | --help)
		_print_help _LIBRARY_PATH_/_APPLICATION_NAME_/help/default
		_print_help _LIBRARY_PATH_/$_APPLICATION_NAME/help/$(basename $0)

		exit 0
		;;
	esac
done
