#!/bin/sh

# allow all configuration items to be set via command-line (override environment / configuration file)
for _ARG in "$@"; do
	case $_ARG in
	--conf*=*)
		_CONF_NAME=${_ARG%%=*}
		_CONF_NAME=${_CONF_NAME#-}
		_CONF_NAME=$(echo $_CONF_NAME | tr '-' '_' | tr '[:lower:]' '[:upper:]')

		export $_CONF_NAME="${_ARG#*=}"
		shift
		;;
	--conf*)
		export $(echo ${_ARG#-} | tr '-' '_' | tr '[:lower:]' '[:upper:]')=1

		shift
		;;
	*)
		break
		;;
	esac
done

if [ -n "$_CONF_NO_PAGER" ]; then
	PAGER=cat
fi
