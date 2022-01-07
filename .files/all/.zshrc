#!/bin/sh

for _ZSH_SCRIPT_ in $(find $_ZSH_RC_PATH -type f); do
	. $_ZSH_SCRIPT_
done
