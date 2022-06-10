#!/bin/sh

_sed_safe() {
	echo $1 | sed -e "s/\//\\\\\//g"
}

_sed_remove_nonprintable_characters() {
	sed -e 's/[^[:print:]]//g'
}
