#!/bin/sh

for _ZSH_SCRIPT_ in $(find $_CONF_SH_RC_PATH/zsh -type f); do
	. $_ZSH_SCRIPT_
done

_after() {
	# use notification script
	powershell -f ~/.config/walterjwhite/console "<SUBJECT>" "<DETAILS>"
}
