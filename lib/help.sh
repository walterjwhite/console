#!/bin/sh

_print_help() {
	if [ -e $1 ]; then
		cat $1
		echo ""
	fi
}
