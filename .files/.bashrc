#!/bin/sh

for _BASHRC_ in $(find $_BASH_RC_PATH -type f); do
	. $_BASHRC_
done
