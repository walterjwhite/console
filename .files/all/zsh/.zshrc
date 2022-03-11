#!/bin/sh

. ~/.config/walterjwhite/console

for _ZSH_SCRIPT_ in $(find $_SH_RC_PATH/zsh -type f); do
	. $_ZSH_SCRIPT_
done
