#!/bin/bash
ip addr add 192.168.221.5/24 dev eth1
ip route add 192.168.0.0/16 via 192.168.221.1


