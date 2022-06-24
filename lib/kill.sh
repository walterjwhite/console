#!/bin/sh

_kill_all() {
	for _EXISTING_APPLICATION_PIPE in $(find $_APPLICATION_PIPE_DIR -type p -not -name $$); do
		_kill $(basename $_EXISTING_APPLICATION_PIPE)
	done
}

_kill() {
	_warn "Killing $1"
	kill -TERM $1
}

_list() {
	. _LIBRARY_PATH_/console/sed.sh

	_info "Running processes:"

	_EXECUTABLE_NAME_SED_SAFE=$(_sed_safe $0)

	for _EXISTING_APPLICATION_PIPE in $(find $_APPLICATION_PIPE_DIR -type p -not -name $$); do
		_TARGET_PID=$(basename $_EXISTING_APPLICATION_PIPE)

		_TARGET_PS_DTL=$(ps -o command -p $_TARGET_PID | sed 1d | sed -e "s/^.*$_EXECUTABLE_NAME_SED_SAFE/$_EXECUTABLE_NAME_SED_SAFE/")

		_info " $_TARGET_PID - $_TARGET_PS_DTL"
	done
}

for _ARG in "$@"; do
	case "$_ARG" in
	-kill-all)
		_kill_all

		_exit_success "Killed"
		;;
	-kill=*)
		_kill ${_ARG#*=}

		_exit_success "Killed"
		;;
	-l)
		_list

		_exit_success "listed running processes"
		;;
	esac
done
