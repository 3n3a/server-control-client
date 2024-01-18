#!/bin/bash
#
# scc - server control client
#
# a client for the server control api
#

BASE_URL="${SCC_BASE_URL:-}"
KEY="${SCC_KEY:-}"
UA=${SCC_UA:-scc/1.0}
EXTRA_HEADERS=${SCC_EXTRA_HEADERS:-} # accepts list of curl args

# functions
request() {
	method="${1:-GET}"
	path="${2:-/}"
	body="${3:-}"
	cmd="curl -fsSL -X $method -H 'Authorization: Bearer $KEY' -H 'User-Agent: $UA' $EXTRA_HEADERS $BASE_URL$path -d '$body'"
	bash -c "$cmd"
}

pull_image() {
	image="${1:-}"
	request "POST" "/docker/images/pull" "image=$image"
}

restart_service() {
	service_name="${1:-}"
	request "POST" "/systemd/restart" "service=$service_name"
}

# main
# echo -e $(bash -c "curl -v -L $EXTRA_HEADERS ifconfig.me/all")

# command switcher
case $1 in

	dk_pull)
		# send pull image request
		pull_image "$2"
		;;

	sd_restart)
		# send systemd restart reqeust
		restart_service "$2"
		;;

	*)
		# return help
		h="server control client - scc\n\n"
		h+="\t$0 COMMAND [OPTIONS...]\n\n"
		h+="\tdk_pull\t\tpull the image on the server\n\n"
		h+="\tsd_restart\t\trestart systemd service\n\n"
		h+="\t-h\t\tshow this help\n"
		echo -e "$h"
		;;
esac

