#!/bin/sh

if [ -z "$_SH_RC_PATH" ]; then
	_exitWithError "_SH_RC_PATH is null, it must be set, recommend: /usr/local/walterjwhite/shrc, custom settings will be installed here"
fi

_ZSH_RC_PATH=$_SH_RC_PATH/zshrc

_console_install() {
	# copy over settings
	mkdir -p $_ZSH_RC_PATH
	if [ -e .zshrc ]; then
		cp .zshrc/* $_ZSH_RC_PATH
	fi
}

_zsh_conf() {
	if [ -e .files/$_PLATFORM/.zshrc ]; then
		cp .files/$_PLATFORM/.zshrc .files/$_PLATFORM/.zlogout $_HOME
	else
		cp .files/all/.zshrc .files/all/.zlogout $_HOME
	fi

	# NOTE: this is for UNIX platforms
	if [ -n "$_OTHER_USER" ]; then
		chown $_OTHER_USER:$_OTHER_USER $_HOME/.zshrc $_HOME/.zlogout
	fi

	$_GNU_SED -i "1 a _ZSH_RC_PATH=$_ZSH_RC_PATH" $_HOME/.zshrc
}
