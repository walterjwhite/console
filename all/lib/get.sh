_console_get() {
	_console_read_context

	_info "Context: $_CONSOLE_CONTEXT_ID | $_CONSOLE_CONTEXT_DESCRIPTION"

	_detail "Context env:"
	sed 1,2d $_CONSOLE_CONTEXT_FILE
}
