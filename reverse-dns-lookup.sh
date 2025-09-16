#!/bin/bash

# Script: reverse-dns-lookup.sh
# Purpose: Perform reverse DNS lookups on a /24 network using a specific DNS server
# Usage: ./reverse-dns-lookup.sh <network_prefix> <dns_server>
# Example: ./reverse-dns-lookup.sh 10.0.5 10.0.5.22

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <dns_server>"
    echo "Example: $0 10.0.5 10.0.5.22"
    exit 1
fi

# Get arguments
network_prefix=$1
dns_server=$2

echo "dns resolution for $network_prefix.0"

# Loop through all IPs in the /24 network
for i in $(seq 1 254); do
    ip="$network_prefix.$i"
    
    # Perform reverse DNS lookup using nslookup with specific DNS server
    result=$(nslookup $ip $dns_server 2>/dev/null)
    
    # Check if we got a valid response (not "can't find" or timeout)
    if echo "$result" | grep -q "name ="; then
        # Extract the hostname from the result and format exactly like the screenshot
        hostname=$(echo "$result" | grep "name =" | awk '{print $4}')
        echo "$ip.in-addr.arpa name = $hostname"
    fi
done
