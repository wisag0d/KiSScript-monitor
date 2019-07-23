REPORT_TIME=$(date +"%Y/%m/%d-%H:%M")
REPORT_CONTENT="*[ERROR]!!!* \`${HOSTNAME}\` Script [${TYPE} ${ACTION}] don't feel so good. from $REPORT_TIME"

# ---

if [ -f $SCRIPT_PATH/report/$REPORT_WAY ]; then 
	. $SCRIPT_PATH/report/$REPORT_WAY
	_REPORT \
		"${REPORT_CONTENT}" > /dev/null 
else
	_ERROR "${REPORT_CONTENT}"
fi
