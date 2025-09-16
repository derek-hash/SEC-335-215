#!/bin/bash

prefix="10.0.5"
port=53

echo "ip,port"

#Scans for each address from 1 to 254
for i in $(seq 1 254)
do
	ip="$prefix.$i"
	#Tries to connect to port 53 (DNS)
	timeout 1 bash -c "echo > /dev/tcp/$ip/$port" >/dev/null 2>&1

	if [ $? -eq 0 ]
	then
		echo "$ip,$port"
	fi
done
