#!/bin/bash

check() {
    var1="$1"
    var2="$2"
    var3="$3"

    docker exec $1 fping -t 50 -ac 1 $2 2> /dev/null && echo "[X] $1 reaches $2 - $3" || echo "[ ] $1 not reaches $2 - $3"
}

echo "Testing Management network"
check sdf-server1 192.168.12.1 "Local Gateway"
check sdf-server1 192.168.12.6 "sdf-server2" 
check sdf-server1 192.168.12.7 "rec-server"
check sdf-server1 192.168.11.5 "center-position"
check sdf-server1 192.168.11.6 "tower-position"
echo "Testing Radar Network"
check sdf-server1 192.168.250.250 "radar"
check sdf-server1 192.168.250.240 "tower-direction-finder"
check sdf-server1 192.168.250.6 "sdf-server2"
check tower-df1 192.168.250.250 "radar"
echo "Testing CHANNEL A/B Network"
check sdf-server1 10.50.1.2 "sdf-server2"
check sdf-server1 10.50.2.2 "sdf-server2"
check sdf-server1 10.50.1.5 "center-position"
check sdf-server1 10.50.2.5 "center-position"
check sdf-server1 10.50.1.6 "tower-position"
check sdf-server1 10.50.2.6 "center-position"
echo "Testing Camera Network"
check rec-server 192.168.220.5 "tower-cam1"
check rec-server 192.168.221.5 "radar-cam1"
