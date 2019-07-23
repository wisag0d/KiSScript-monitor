webhook_url="$REPORT_API"
_REPORT () {
	curl -H "Content-Type: multipart/form-data" -X POST \
		-F content="$1" -F file=@$LOG_PATH/$ACTION.error.log \
		"${webhook_url}"
}
