#!/bin/sh

_sed_safe() {
	echo $1 | sed -e "s/\//\\\\\//g"
}
