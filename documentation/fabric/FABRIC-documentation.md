# FABRIC

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| FABRIC | l3leaf | acc-leaf2-1 | 172.22.0.105/24 | cEOS-lab | Provisioned | - |
| FABRIC | l3leaf | acc-leaf2-2 | 172.22.0.106/24 | cEOS-lab | Provisioned | - |
| FABRIC | l3leaf | radar-edge1-1 | 172.22.0.109/24 | cEOS-lab | Provisioned | - |
| FABRIC | l3leaf | radar-edge1-2 | 172.22.0.110/24 | cEOS-lab | Provisioned | - |
| FABRIC | l3leaf | rz-leaf1-1 | 172.22.0.103/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | rz-leaf1-2 | 172.22.0.104/24 | vEOS-lab | Provisioned | - |
| FABRIC | spine | rz-spine1 | 172.22.0.101/24 | cEOS-lab | Provisioned | - |
| FABRIC | spine | rz-spine2 | 172.22.0.102/24 | cEOS-lab | Provisioned | - |
| FABRIC | l2leaf | tower-leaf3-1 | 172.22.0.107/24 | cEOS-lab | Provisioned | - |
| FABRIC | l2leaf | tower-leaf3-2 | 172.22.0.108/24 | cEOS-lab | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | --------- | -------------- |
| l3leaf | acc-leaf2-1 | Ethernet1 | spine | rz-spine1 | Ethernet3 |
| l3leaf | acc-leaf2-1 | Ethernet2 | spine | rz-spine2 | Ethernet3 |
| l3leaf | acc-leaf2-1 | Ethernet3 | mlag_peer | acc-leaf2-2 | Ethernet3 |
| l3leaf | acc-leaf2-1 | Ethernet4 | mlag_peer | acc-leaf2-2 | Ethernet4 |
| l3leaf | acc-leaf2-1 | Ethernet8 | l2leaf | tower-leaf3-1 | Ethernet1 |
| l3leaf | acc-leaf2-2 | Ethernet1 | spine | rz-spine1 | Ethernet4 |
| l3leaf | acc-leaf2-2 | Ethernet2 | spine | rz-spine2 | Ethernet4 |
| l3leaf | radar-edge1-1 | Ethernet3 | mlag_peer | radar-edge1-2 | Ethernet3 |
| l3leaf | radar-edge1-1 | Ethernet4 | mlag_peer | radar-edge1-2 | Ethernet4 |
| l3leaf | rz-leaf1-1 | Ethernet1 | spine | rz-spine1 | Ethernet1 |
| l3leaf | rz-leaf1-1 | Ethernet2 | spine | rz-spine2 | Ethernet1 |
| l3leaf | rz-leaf1-1 | Ethernet3 | mlag_peer | rz-leaf1-2 | Ethernet3 |
| l3leaf | rz-leaf1-1 | Ethernet4 | mlag_peer | rz-leaf1-2 | Ethernet4 |
| l3leaf | rz-leaf1-2 | Ethernet1 | spine | rz-spine1 | Ethernet2 |
| l3leaf | rz-leaf1-2 | Ethernet2 | spine | rz-spine2 | Ethernet2 |
| l2leaf | tower-leaf3-1 | Ethernet3 | mlag_peer | tower-leaf3-2 | Ethernet3 |
| l2leaf | tower-leaf3-1 | Ethernet4 | mlag_peer | tower-leaf3-2 | Ethernet4 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 10.255.201.0/26 | 64 | 8 | 12.5 % |
| 10.255.202.0/26 | 64 | 8 | 12.5 % |
| 10.255.204.0/26 | 64 | 0 | 0.0 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| acc-leaf2-1 | Ethernet1 | 10.255.202.17/31 | rz-spine1 | Ethernet3 | 10.255.202.16/31 |
| acc-leaf2-1 | Ethernet2 | 10.255.202.19/31 | rz-spine2 | Ethernet3 | 10.255.202.18/31 |
| acc-leaf2-2 | Ethernet1 | 10.255.202.21/31 | rz-spine1 | Ethernet4 | 10.255.202.20/31 |
| acc-leaf2-2 | Ethernet2 | 10.255.202.23/31 | rz-spine2 | Ethernet4 | 10.255.202.22/31 |
| rz-leaf1-1 | Ethernet1 | 10.255.201.9/31 | rz-spine1 | Ethernet1 | 10.255.201.8/31 |
| rz-leaf1-1 | Ethernet2 | 10.255.201.11/31 | rz-spine2 | Ethernet1 | 10.255.201.10/31 |
| rz-leaf1-2 | Ethernet1 | 10.255.201.13/31 | rz-spine1 | Ethernet2 | 10.255.201.12/31 |
| rz-leaf1-2 | Ethernet2 | 10.255.201.15/31 | rz-spine2 | Ethernet2 | 10.255.201.14/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.255.1.0/24 | 256 | 6 | 2.35 % |
| 10.255.3.0/24 | 256 | 2 | 0.79 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| FABRIC | acc-leaf2-1 | 10.255.1.5/32 |
| FABRIC | acc-leaf2-2 | 10.255.1.6/32 |
| FABRIC | radar-edge1-1 | 10.255.3.9/32 |
| FABRIC | radar-edge1-2 | 10.255.3.10/32 |
| FABRIC | rz-leaf1-1 | 10.255.1.3/32 |
| FABRIC | rz-leaf1-2 | 10.255.1.4/32 |
| FABRIC | rz-spine1 | 10.255.1.1/32 |
| FABRIC | rz-spine2 | 10.255.1.2/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |
| 10.255.2.0/27 | 32 | 4 | 12.5 % |
| 10.255.4.0/27 | 32 | 2 | 6.25 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| FABRIC | acc-leaf2-1 | 10.255.2.5/32 |
| FABRIC | acc-leaf2-2 | 10.255.2.5/32 |
| FABRIC | radar-edge1-1 | 10.255.4.9/32 |
| FABRIC | radar-edge1-2 | 10.255.4.9/32 |
| FABRIC | rz-leaf1-1 | 10.255.2.3/32 |
| FABRIC | rz-leaf1-2 | 10.255.2.3/32 |
