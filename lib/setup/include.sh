#!/bin/sh

if [ -z "$_CONF_SH_RC_PATH" ]; then
	_exitWithError "_CONF_SH_RC_PATH is null, it must be set, recommend: /usr/local/walterjwhite/shrc, custom settings will be installed here"
fi

_console_install() {
	# copy over settings
	mkdir -p $_CONF_SH_RC_PATH/$_SHELL
	if [ -e .console/all/$_SHELL ]; then
		cp .console/all/$_SHELL/* $_CONF_SH_RC_PATH/$_SHELL
	fi
}

_console_conf() {
	for _F in $(find .files/all/$_SHELL -type f); do
		cp $_F $_HOME

		_console_permissions
	done

	if [ -e .files/$_PLATFORM/$_SHELL ]; then
		for _F in $(find .files/$_PLATFORM/$_SHELL -type f); do
			cp $_F $_HOME

			_console_permissions
		done
	fi
}

_console_permissions() {
	# NOTE: this is for UNIX platforms
	if [ -n "$_OTHER_USER" ]; then
		chown $_OTHER_USER:$_OTHER_USER $_HOME/$(basename $_F)
	fi
}
