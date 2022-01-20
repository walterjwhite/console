#!/bin/sh

_enable_debug() {
	_DEBUG=1
	set -x

	export _DEBUG
}

if [ -n "$_DEBUG" ]; then
	_enable_debug
fi
