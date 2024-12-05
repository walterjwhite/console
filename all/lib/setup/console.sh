import git:git/include.sh
conf git

_console_conf() {
	_require_file $_HOME "_console_conf:_HOME"

	local opwd=$PWD
	cd $_CONF_INSTALL_DATA_REGISTRY_PATH/$_TARGET_APPLICATION_NAME

	find $(dirname $(dirname $0))/files/$_TARGET_APPLICATION_NAME/$_SHELL -type f -exec $_SUDO_CMD cp {} $_HOME \; || _warn "console conf: $PWD -> $(ls)"

	[ -z "$_USER" ] && _USER=$(whoami)

	_console_init_git_data

	cd $opwd
}

_console_init_git_data() {
	_info "  init git data: $_HOME : $_USER"

	_configure $_HOME/.config/walterjwhite/$_TARGET_APPLICATION_NAME
	_configure $_HOME/.config/walterjwhite/install
	_configure $_HOME/.config/walterjwhite/git

	_PROJECT_PATH=$_HOME/.data/$_TARGET_APPLICATION_NAME
	_PROJECT=data/$(head -1 /usr/local/etc/walterjwhite/system 2>/dev/null)/$_USER/$_TARGET_APPLICATION_NAME

	_git_init
	_console_fix_permissions
}

_console_fix_permissions() {
	[ "$_USER" = "root" ] && return 1

	local chown_args="$_USER:$_USER"
	if [ $_PLATFORM = "Apple" ]; then
		chown_args="$_USER"
	fi

	_sudo chown -R $chown_args $_PROJECT_PATH
}
