#!/bin/sh

# colors - allow user to override
_C_ERR="1;31m"
_C_SCS="1;32m"
_C_WRN="1;33m"
_C_INFO="1;36m"
_C_DETAIL="1;0;36m"
_C_DBG="1;35m"

_C_STDIN="1;34m"

tty >/dev/null
_NON_INTERACTIVE=$?

_optionalInclude() {
	if [ -e $1 ]; then
		. $1
	else
		_debug "$1 does NOT exist"
	fi
}

_exitWithError() {
	_print_log ERR "$_C_ERR" "$1"

	exit $2
}

_exitSuccess() {
	_print_log SCS "$_C_SCS" "$1"

	exit 0
}

_warn() {
	_print_log WARN "$_C_WRN" "$1"
}

_info() {
	_print_log INFO "$_C_INFO" "$1"
}

_detail() {
	_print_log INFO "$_C_DETAIL" "$1"
}

_DATE_FORMAT="%Y/%m/%d %H:%M:%S"
_debug() {
	if [ -n "$_DEBUG" ]; then
		_print_log DBG "$_C_DBG" "$1" "$(date "+$_DATE_FORMAT") "
	fi
}

_print_log() {
	local _level=$1
	local _color=$2
	local _message="$3"

	local _pretext="$4"

	if [ $_NON_INTERACTIVE -eq 0 ]; then
		echo >&2 -e "${_pretext}\e[${_color}$_message\e[0m"
	else
		_doLog $_level "$_message"
	fi
}

_require() {
	if [ -z "$1" ]; then
		_exitWithError "$2 required" $3
	fi
}

_read_if() {
	if [ $_NON_INTERACTIVE -eq 0 ]; then
		echo >&2 -e "\e[1;3;${_C_STDIN}${1}\e[0m ${3}"
		read $2
	else
		_exitWithError "Running in non-interactive mode and user input was requested" 10
	fi
}

_continue_if() {
	clear

	_read_if "$1" _PROCEED "$2"
	clear

	if [ -z "$_PROCEED" ]; then
		_DEFAULT=$(echo $2 | awk -F'/' {'print$1'})
		_PROCEED=$_DEFAULT
	fi

	if [ $_PROCEED = "n" ]; then
		return 1
	fi

	return 0
}

_() {
	if [ -z "$_DRY_RUN" ]; then
		"$@"

		local _exitStatus=$?
		if [ $_exitStatus -gt 0 ]; then
			if [ -n "$_ON_FAILURE" ]; then
				$_ON_FAILURE
				return
			fi

			if [ -z "$WARN_ON_ERROR" ]; then
				_exitWithError "Previous cmd failed" $_exitStatus
			else
				_warn "Previous cmd failed - $@ - $_exitStatus"
			fi
		fi
	else
		_info "$@"
	fi
}

_in_data_path() {
	return $(pwd | grep -c $_DATA_PATH)
}

_contains_argument() {
	local _key=$1
	shift

	for _ARG in "$@"; do
		case $_ARG in
		$_key)
			echo 1
			return
			;;
		esac
	done

	echo 0
}

_debug "Application Name: $_APPLICATION_NAME:$_APPLICATION_VERSION" "$_APPLICATION_BUILD_DATE / $_APPLICATION_INSTALL_DATE @ $_APPLICATION_DATA_PATH"

if [ -n "$_DEBUG" ]; then
	set -x
fi
