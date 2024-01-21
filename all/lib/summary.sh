import git:install/time.sh

_console_summary() {
	cd $_CONF_INSTALL_APPLICATION_DATA_PATH

	$EDITOR $_CONSOLE_CONTEXT_ID/summary

	git add $_CONSOLE_CONTEXT_ID/summary &&
		git commit $_CONSOLE_CONTEXT_ID/summary -m "summary - $_CONSOLE_CONTEXT_ID" &&
		git push
}
