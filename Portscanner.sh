#!/bin/bash
# Simple port scanner - Team: Derek + teammates
# Enhancement: Added basic error checking and CSV headers

# Error checking
if [ $# -ne 2 ]; then
    echo "Usage: $0 hostfile portfile"
    exit 1
fi

hostfile=$1
portfile=$2

# CSV header enhancement
echo "host,port,status"

for host in $(cat $hostfile); do
    for port in $(cat $portfile); do
        if timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
            echo "$host,$port,open"
        else
            echo "$host,$port,closed"
        fi
    done
done
