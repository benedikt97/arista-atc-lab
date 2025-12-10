#!/bin/bash
hostnamectl hostname sdf-server1
BOND_NAME="bond0"
SLAVE1="eth1"
SLAVE2="eth2"
BOND_IP="192.168.12.5/24"
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



ip link add link ${BOND_NAME} name ${BOND_NAME}.250 type vlan id 250
ip link set ${BOND_NAME}.250 up
ip addr add 192.168.250.5/24 dev ${BOND_NAME}.250

ip link add link ${BOND_NAME} name ${BOND_NAME}.3401 type vlan id 3401
ip link set ${BOND_NAME}.3401 up
ip addr add 10.50.1.1/24 dev ${BOND_NAME}.3401

ip link add link ${BOND_NAME} name ${BOND_NAME}.3402 type vlan id 3402
ip link set ${BOND_NAME}.3402 up
ip addr add 10.50.2.1/24 dev ${BOND_NAME}.3402

ip route add 192.168.0.0/16 via 192.168.12.1


