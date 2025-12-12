#!/bin/bash
set -x
sleep 5
/usr/lib/frr/bgpd -d
/usr/lib/frr/nhrpd -d
sleep 5
ip tunnel add gre1 mode gre local 138.10.1.2 remote 138.10.1.1
ip link set gre1 up
sleep 5
vtysh -f router.cmd
