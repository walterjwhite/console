import git:install/time.sh

_console_unarchive() {
	_UNARCHIVE_CONTEXT_ID=$1
	shift

	_require "$_UNARCHIVE_CONTEXT_ID" "_UNARCHIVE_CONTEXT_ID"

	if [ "$_CONTEXT_ID" = "$_UNARCHIVE_CONTEXT_ID" ]; then
		_error "Cannot unarchive active context"
	fi

	cd $_CONF_INSTALL_APPLICATION_DATA_PATH

	_TARGET_CONTEXT_PATH=$(find archived -type d -name "$_UNARCHIVE_CONTEXT_ID")
	_require "$_TARGET_CONTEXT_PATH" _TARGET_CONTEXT_PATH

	git mv $_TARGET_CONTEXT_PATH $_UNARCHIVE_CONTEXT_ID &&
		git commit $_TARGET_CONTEXT_PATH $_UNARCHIVE_CONTEXT_ID -m "unarchive $_UNARCHIVE_CONTEXT_ID" &&
		git push

	_console_set $_UNARCHIVE_CONTEXT_ID
}
