#!/bin/bash

check_ip() {
	local host="$1"
	local ip="$2"
	local dns="$3"

	nslookup "$host" "$dns" 2>/dev/null \
		| awk '/^Name:/ {f=1} f && /^Address/ {print $NF}' \
		| grep -qxF "$ip"
}

DNS_SERVER="${1:-8.8.8.8}"

while read -r ip names; do
	if [ -z "$ip" ] || [[ "$ip" == \#* ]]; then
		continue
	fiS

	for name in $names; do
		[[ "$name" == \#* ]] && break   #

		if ! check_ip "$name" "$ip" "$DNS_SERVER"; then
			echo "Bogus IP for $name in /etc/hosts"
		fi
	done
done < /etc/hosts
