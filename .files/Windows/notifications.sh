#!/bin/sh

if [ $# -ne 3 ]; then
	echo "3 args are required (app name, title, body)"
	exit 1
fi

powershell -f _LIBRARY_PATH_/_APPLICATION_NAME_/notifications.ps1 $@
