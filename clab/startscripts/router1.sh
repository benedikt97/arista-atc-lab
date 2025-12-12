#!/bin/bash
exec 1>server.log 2>&1
set -x
while ! pgrep zebra >/dev/null; do
    sleep 0.1
done
ip tunnel add gre2 mode gre local 138.10.1.1 remote 138.10.1.2
ip link set gre0 up
vtysh -f router.cmd
vtysh -c "write memory"


