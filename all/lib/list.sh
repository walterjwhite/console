_console_list() {
	sed_safe_path=$(_sed_safe $_CONF_INSTALL_APPLICATION_DATA_PATH)
	find $_CONF_INSTALL_APPLICATION_DATA_PATH -type d -maxdepth 1 ! -name .git ! -name .activity ! -name .archived | sed -e "s/$sed_safe_path//" -e 's/^\///' | grep -v '^$'
}
