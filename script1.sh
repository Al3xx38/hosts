#!/bin/bash

cat /etc/hosts | while read ip names; do
	if [ -z "$ip" ] || [[ "$ip" == \#* ]]; then
    continue
	fi

	for name in $names; do
		if ! nslookup "$name" | grep -q "$ip"; then
			echo "Bogus IP for $name in /etc/hosts"
		fi
	done
done
