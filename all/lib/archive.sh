import git:install/time.sh

_console_archive() {
	_ARCHIVE_CONTEXT_ID=$1
	shift

	_require "$_ARCHIVE_CONTEXT_ID" "_ARCHIVE_CONTEXT_ID"

	if [ "$_CONTEXT_ID" = "$_ARCHIVE_CONTEXT_ID" ]; then
		_error "Cannot archive active context"
	fi

	cd $_CONF_INSTALL_APPLICATION_DATA_PATH

	_TARGET_CONTEXT_PATH=archived/$(_time_decade)/$(date +%Y/%m.%B/%d/)
	mkdir -p $_TARGET_CONTEXT_PATH

	git mv $_ARCHIVE_CONTEXT_ID $_TARGET_CONTEXT_PATH/$_ARCHIVE_CONTEXT_ID &&
		git commit -am "archived $_ARCHIVE_CONTEXT_ID" &&
		git push
}
