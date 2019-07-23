webhook_url="$REPORT_API"
upload_log="$(cat $LOG_PATH/$ACTION.error.log)"
_REPORT () {
	if [ -n "$upload_log" ]; then
		message="$1 \`\`\`$upload_log\`\`\`"
	else
		message="$1"
	fi
	curl -H "Content-type: application/json" -X POST \
		-d "{ \"text\": \"$message\" }" \
		"${webhook_url}"
}
