#!/bin/sh

. ~/.config/walterjwhite/console

for _BASHRC_ in $(find $_CONF_SH_RC_PATH/bash -type f); do
	. $_BASHRC_
done
