#!/bin/bash
/usr/lib/frr/bgpd -d
/usr/lib/frr/nhrpd -d
ip tunnel add gre1 mode gre local 138.10.1.2 remote 138.10.1.1
ip link set gre1 up
sleep 2
vtysh -f router.cmd
