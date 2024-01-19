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
	cmd="curl -ksSL -X $method -H 'Authorization: Bearer $KEY' -H 'User-Agent: $UA' $EXTRA_HEADERS $BASE_URL$path -d '$body'"
	echo $cmd
	bash -c "$cmd"
}

pull_image() {
	image="${1:-}"
	request "POST" "/docker/images/pull" "image=$image"
}

restart_container() {
	service_name="${1:-}"
	request "POST" "/docker/containers/restart" "name=$service_name"
}

restart_service() {
	service_name="${1:-}"
	if [[ $service_name != *".service" ]]; then
		service_name+=".service"
	fi
	request "POST" "/systemd/restart" "name=$service_name"
}

# main

# command switcher
case $1 in

	image_pull)
		# send pull image request
		pull_image "$2"
		;;

	container_restart)
		# send container restart reqeust
		restart_container "$2"
		;;
 	
	service_restart)
		# send service restart reqeust
		restart_service "$2"
		;;

	*)
		# return help
		h="server control client - scc\n\n"
		h+="\t$0 COMMAND [OPTIONS...]\n\n"
		h+="\n"
		h+="\t# docker\n\n"
		h+="\timage_pull\t\tpull the image on the server\n\n"
		h+="\tcontainer_restart\trestart container service\n\n"
		h+="\n"
		h+="\t# systemd\n\n"
		h+="\tservice_restart\t\trestart systemd service\n\n"
		h+="\t-h\t\t\tshow this help\n"
		echo -e "$h"
		;;
esac

