#!/bin/sh
#  _  _____ ____ ____            _       _   
# | |/ /_ _/ ___/ ___|  ___ _ __(_)_ __ | |_ 
# | ' / | |\___ \___ \ / __| '__| | '_ \| __|
# | . \ | | ___) |__) | (__| |  | | |_) | |_ 
# |_|\_\___|____/____/ \___|_|  |_| .__/ \__|
# Keep It Simplem Stupid          |_|        
# Load Config -> Load OUTPUT Function -> Checking File
# ( Script -> Generate .log ) -> error return -> Move to Error log.
# with *.error.log exist -> run somename script in Report, Recover folder

# --- Custom Variables
SCRIPT_PATH="$(dirname $0)"
LOG_PATH="$SCRIPT_PATH/log"

# --- Function 
. $SCRIPT_PATH/config.sh
_OUTPUT () {
	echo "$(date +'%y/%m/%d %H:%M:%S') | [info] $1"
}
_ERROR () {
	TIME=$(date +'%y/%m/%d %H:%M:%S')
	>&2 echo "$(date +'%y/%m/%d %H:%M:%S') | [error] $1"
	return 1
}

# --- Main Program
# Before runing, Checking ARGS...
_OUTPUT "Checking ARGS.."
if [ -z "${1}" ] || [ -z "${2}" ]; then 
	_ERROR "Not input your TYPE and ACTION."
	exit 1
fi
TYPE=${1}; ACTION=${2}
_OUTPUT "Checking file exist"
if ! [ -f "$SCRIPT_PATH/$TYPE/$ACTION" ]; then
	_ERROR "$ACTION don't exist"
	exit 1
fi

# Running Script
_OUTPUT "Run Script..."
$RUN_PATH $SCRIPT_PATH/$TYPE/$ACTION &> $LOG_PATH/$ACTION.log
if [ "$?" -ne "0" ]; then
	_ERROR "$ACTION is something wrong."
	cat $LOG_PATH/$ACTION.log >> $LOG_PATH/$ACTION.error.log
fi 
rm $LOG_PATH/$ACTION.log

# Checking any error happen...
_OUTPUT "Check any error.log exist"
if [ -e "$LOG_PATH/$ACTION.error.log" ]; then
	_OUTPUT "Check Any recover action."
	# Recover Part
	if [ -f $SCRIPT_PATH/recover/$ACTION ]; then
		_ERROR "Start recover $ACTION..."
		$SCRIPT_PATH/recover/$ACTION &>> $LOG_PATH/$ACTION.error.log
		if [ "$?" -ne "0" ]; then
			_ERROR "!! Recove $ACTION Failed."
		fi
	fi

	# Report Part
	_ERROR "Report error about $ACTION..."
	if [ -f $SCRIPT_PATH/report/$ACTION ]; then
		. $SCRIPT_PATH/report/$ACTION
		if [ "$?" -ne "0" ]; then
			_ERROR "!! Report $ACTION Failed."
			exit
		fi
	else
		. $SCRIPT_PATH/report/00_default.sh
	fi
	cat $LOG_PATH/$ACTION.error.log >> $LOG_PATH/$(date +%Y%m%d).$ACTION.error.log
	rm $LOG_PATH/$ACTION.error.log
fi
