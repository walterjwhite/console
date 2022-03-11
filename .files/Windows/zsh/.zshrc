#!/bin/sh

for _ZSH_SCRIPT_ in $(find $_ZSH_RC_PATH -type f); do
	. $_ZSH_SCRIPT_
done

_after() {
	# use notification script
	# TODO: automatically run appropriate setup scripts for detected OS
	# TODO: automatically install configuration + script (when on windows)
	# TODO: pass subject, details
	powershell -f ~/.config/walterjwhite/console "<SUBJECT>" "<DETAILS>"
}
