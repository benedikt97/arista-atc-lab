#!/bin/bash
hostnamectl hostname radar
BOND_NAME="bond0"
SLAVE1="eth1"
SLAVE2="eth2"
BOND_IP="192.168.250.250/24"
BOND_MODE="802.3ad" 
modprobe bonding
ip link set ${SLAVE1} down 2>/dev/null
ip link set ${SLAVE2} down 2>/dev/null
ip link del ${BOND_NAME} 2>/dev/null
ip link add ${BOND_NAME} type bond mode ${BOND_MODE}
ip link set ${BOND_NAME} type bond miimon 100
ip link set ${BOND_NAME} type bond lacp_rate fast
ip link set ${BOND_NAME} type bond xmit_hash_policy layer3+4
ip link set ${SLAVE1} down
ip link set ${SLAVE1} master ${BOND_NAME}
ip link set ${SLAVE2} down
ip link set ${SLAVE2} master ${BOND_NAME}
ip link set ${BOND_NAME} up
ip addr add ${BOND_IP} dev ${BOND_NAME}




socat_loop () {
    while true; do
    echo "This is a radar message" | \
    socat - UDP4-DATAGRAM:239.4.3.4:9003,ip-multicast-if=192.168.250.250,ip-multicast-ttl=10
    sleep 1
    done
}
socat_loop &
