#!/bin/bash
ip addr add 192.168.221.5/24 dev eth1
ip route add 192.168.0.0/16 via 192.168.221.1





socat_loop () {
    while true; do
    pv -L 1M /dev/random | socat -b 1000 -u - UDP:192.168.219.5:9000
    done
}
socat_loop &



