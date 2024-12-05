_console_comments() {
	cd $_CONF_INSTALL_APPLICATION_DATA_PATH

	local comment_name
	local comment_file
	for comment_file in $(find active/.comments -type f 2>/dev/null | sort -h); do
		comment_name=$(printf '%s\n' "$comment_file" | sed -e 's/^.*\.comments\///')

		_info "$comment_name"
		cat $comment_file

		printf '\n'
	done
}
