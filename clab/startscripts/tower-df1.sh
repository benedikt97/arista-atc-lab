#!/bin/bash
ip addr add 192.168.250.240/24 dev eth1
ip route add 192.168.0.0/16 via 192.168.250.1



socat_loop () {
    while true; do
    echo "This is a radar message" | \
    socat - UDP4-DATAGRAM:255.255.255.255:5000,bind=192.168.250.240,broadcast
    sleep 1
    done
}

socat_loop &
