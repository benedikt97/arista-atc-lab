# acc-leaf2-1

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [Enable Password](#enable-password)
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | OOB_MANAGEMENT | oob | MGMT | 172.22.0.105/24 | 172.22.0.1 |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | OOB_MANAGEMENT | oob | MGMT | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management0
   description OOB_MANAGEMENT
   no shutdown
   vrf MGMT
   ip address 172.22.0.105/24
```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | UNIX-Socket | Default Services |
| ---- | ----- | ----------- | ---------------- |
| False | True | - | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| admin | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 <removed>
```

### Enable Password

Enable password has been disabled

## MLAG

### MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| CENTER-LEAF2 | Vlan4094 | 10.255.255.73 | Port-Channel3 |

Dual primary detection is disabled.

### MLAG Device Configuration

```eos
!
mlag configuration
   domain-id CENTER-LEAF2
   local-interface Vlan4094
   peer-address 10.255.255.73
   peer-link Port-Channel3
   reload-delay mlag 300
   reload-delay non-mlag 330
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 4096 |

#### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
spanning-tree mst 0 priority 4096
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 10 | VRFEXT_VLAN11_EXT | - |
| 11 | VRFEXT_VLAN11_CLIENT | - |
| 12 | VRF10_VLAN12_SERVER | - |
| 219 | VRFRDR_VLAN219_REC | - |
| 220 | VRFRDR_VLAN220_CAM_TOWER | - |
| 250 | VRFRDR_VLAN250_RDR | - |
| 3009 | MLAG_L3_VRF_VRFEXT | MLAG |
| 3010 | MLAG_L3_VRF_VRF-RDR | MLAG |
| 3011 | MLAG_L3_VRF_VRF-CAM | MLAG |
| 3401 | CHANNEL-A | - |
| 3402 | CHANNEL-B | - |
| 4093 | MLAG_L3 | MLAG |
| 4094 | MLAG | MLAG |

### VLANs Device Configuration

```eos
!
vlan 10
   name VRFEXT_VLAN11_EXT
!
vlan 11
   name VRFEXT_VLAN11_CLIENT
!
vlan 12
   name VRF10_VLAN12_SERVER
!
vlan 219
   name VRFRDR_VLAN219_REC
!
vlan 220
   name VRFRDR_VLAN220_CAM_TOWER
!
vlan 250
   name VRFRDR_VLAN250_RDR
!
vlan 3009
   name MLAG_L3_VRF_VRFEXT
   trunk group MLAG
!
vlan 3010
   name MLAG_L3_VRF_VRF-RDR
   trunk group MLAG
!
vlan 3011
   name MLAG_L3_VRF_VRF-CAM
   trunk group MLAG
!
vlan 3401
   name CHANNEL-A
!
vlan 3402
   name CHANNEL-B
!
vlan 4093
   name MLAG_L3
   trunk group MLAG
!
vlan 4094
   name MLAG
   trunk group MLAG
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet3 | MLAG_acc-leaf2-2_Ethernet3 | *trunk | *- | *- | *MLAG | 3 |
| Ethernet4 | MLAG_acc-leaf2-2_Ethernet4 | *trunk | *- | *- | *MLAG | 3 |
| Ethernet5 | SERVER_center-position1_eth1 | *trunk | *11,3401-3402 | *11 | *- | 5 |
| Ethernet8 | L2_tower-leaf3-1_Ethernet1 | *trunk | *10-12,219-220,250,3401-3402 | *- | *- | 8 |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_rz-spine1_Ethernet3 | - | 10.255.202.17/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_rz-spine2_Ethernet3 | - | 10.255.202.19/31 | default | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_rz-spine1_Ethernet3
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.202.17/31
!
interface Ethernet2
   description P2P_rz-spine2_Ethernet3
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.202.19/31
!
interface Ethernet3
   description MLAG_acc-leaf2-2_Ethernet3
   no shutdown
   channel-group 3 mode active
!
interface Ethernet4
   description MLAG_acc-leaf2-2_Ethernet4
   no shutdown
   channel-group 3 mode active
!
interface Ethernet5
   description SERVER_center-position1_eth1
   no shutdown
   channel-group 5 mode active
!
interface Ethernet8
   description L2_tower-leaf3-1_Ethernet1
   no shutdown
   channel-group 8 mode active
```

### Port-Channel Interfaces

#### Port-Channel Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel3 | MLAG_acc-leaf2-2_Port-Channel3 | trunk | - | - | MLAG | - | - | - | - |
| Port-Channel5 | SERVER_center-position1_Bond0 | trunk | 11,3401-3402 | 11 | - | - | - | - | 0000:0000:0001:0002:0001 |
| Port-Channel8 | L2_TOWER-LEAF3_Port-Channel1 | trunk | 10-12,219-220,250,3401-3402 | - | - | - | - | - | - |

##### EVPN Multihoming

####### EVPN Multihoming Summary

| Interface | Ethernet Segment Identifier | Multihoming Redundancy Mode | Route Target |
| --------- | --------------------------- | --------------------------- | ------------ |
| Port-Channel5 | 0000:0000:0001:0002:0001 | all-active | 00:01:00:02:00:01 |

#### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel3
   description MLAG_acc-leaf2-2_Port-Channel3
   no shutdown
   switchport mode trunk
   switchport trunk group MLAG
   switchport
!
interface Port-Channel5
   description SERVER_center-position1_Bond0
   no shutdown
   switchport trunk native vlan 11
   switchport trunk allowed vlan 11,3401,3402
   switchport mode trunk
   switchport
   !
   evpn ethernet-segment
      identifier 0000:0000:0001:0002:0001
      route-target import 00:01:00:02:00:01
   lacp system-id 0001.0002.0001
   spanning-tree portfast
!
interface Port-Channel8
   description L2_TOWER-LEAF3_Port-Channel1
   no shutdown
   switchport trunk allowed vlan 10-12,219-220,250,3401-3402
   switchport mode trunk
   switchport
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | ROUTER_ID | default | 10.255.1.5/32 |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | 10.255.2.5/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | ROUTER_ID | default | - |
| Loopback1 | VXLAN_TUNNEL_SOURCE | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 10.255.1.5/32
!
interface Loopback1
   description VXLAN_TUNNEL_SOURCE
   no shutdown
   ip address 10.255.2.5/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | VRFEXT_VLAN11_EXT | VRFEXT | - | False |
| Vlan11 | VRFEXT_VLAN11_CLIENT | VRFEXT | - | False |
| Vlan12 | VRF10_VLAN12_SERVER | VRFEXT | - | False |
| Vlan219 | VRFRDR_VLAN219_REC | VRF-CAM | - | False |
| Vlan220 | VRFRDR_VLAN220_CAM_TOWER | VRF-CAM | - | False |
| Vlan250 | VRFRDR_VLAN250_RDR | VRF-RDR | - | False |
| Vlan3009 | MLAG_L3_VRF_VRFEXT | VRFEXT | 1500 | False |
| Vlan3010 | MLAG_L3_VRF_VRF-RDR | VRF-RDR | 1500 | False |
| Vlan3011 | MLAG_L3_VRF_VRF-CAM | VRF-CAM | 1500 | False |
| Vlan4093 | MLAG_L3 | default | 1500 | False |
| Vlan4094 | MLAG | default | 1500 | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ------ | ------- |
| Vlan10 |  VRFEXT  |  -  |  192.168.10.1/24  |  -  |  -  |  -  |
| Vlan11 |  VRFEXT  |  -  |  192.168.11.1/24  |  -  |  -  |  -  |
| Vlan12 |  VRFEXT  |  -  |  192.168.12.1/24  |  -  |  -  |  -  |
| Vlan219 |  VRF-CAM  |  -  |  192.168.219.1/24  |  -  |  -  |  -  |
| Vlan220 |  VRF-CAM  |  -  |  192.168.220.1/24  |  -  |  -  |  -  |
| Vlan250 |  VRF-RDR  |  -  |  192.168.250.1/24  |  -  |  -  |  -  |
| Vlan3009 |  VRFEXT  |  10.255.255.104/31  |  -  |  -  |  -  |  -  |
| Vlan3010 |  VRF-RDR  |  10.255.255.104/31  |  -  |  -  |  -  |  -  |
| Vlan3011 |  VRF-CAM  |  10.255.255.104/31  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.255.255.104/31  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.255.255.72/31  |  -  |  -  |  -  |  -  |

##### IPv6

| Interface | VRF | IPv6 Address | IPv6 Virtual Addresses | Virtual Router Addresses | ND RA Disabled | Managed Config Flag | Other Config Flag | IPv6 ACL In | IPv6 ACL Out |
| --------- | --- | ------------ | ---------------------- | ------------------------ | -------------- | ------------------- | ----------------- | ----------- | ------------ |
| Vlan10 | VRFEXT | - | 2001:DB8:D10::1/48 | - | - | - | - | - | - |
| Vlan11 | VRFEXT | - | 2001:DB8:D11::1/48 | - | - | - | - | - | - |
| Vlan12 | VRFEXT | - | 2001:DB8:D12::1/48 | - | - | - | - | - | - |
| Vlan219 | VRF-CAM | - | 2001:DB8:D219::1/48 | - | - | - | - | - | - |
| Vlan220 | VRF-CAM | - | 2001:DB8:D220::1/48 | - | - | - | - | - | - |
| Vlan250 | VRF-RDR | - | 2001:DB8:D250::1/48 | - | - | - | - | - | - |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description VRFEXT_VLAN11_EXT
   no shutdown
   vrf VRFEXT
   ipv6 enable
   ip address virtual 192.168.10.1/24
   ipv6 address virtual 2001:DB8:D10::1/48
!
interface Vlan11
   description VRFEXT_VLAN11_CLIENT
   no shutdown
   vrf VRFEXT
   ipv6 enable
   ip address virtual 192.168.11.1/24
   ipv6 address virtual 2001:DB8:D11::1/48
!
interface Vlan12
   description VRF10_VLAN12_SERVER
   no shutdown
   vrf VRFEXT
   ipv6 enable
   ip address virtual 192.168.12.1/24
   ipv6 address virtual 2001:DB8:D12::1/48
!
interface Vlan219
   description VRFRDR_VLAN219_REC
   no shutdown
   vrf VRF-CAM
   ipv6 enable
   ip address virtual 192.168.219.1/24
   ipv6 address virtual 2001:DB8:D219::1/48
!
interface Vlan220
   description VRFRDR_VLAN220_CAM_TOWER
   no shutdown
   vrf VRF-CAM
   ipv6 enable
   ip address virtual 192.168.220.1/24
   ipv6 address virtual 2001:DB8:D220::1/48
!
interface Vlan250
   description VRFRDR_VLAN250_RDR
   no shutdown
   vrf VRF-RDR
   ipv6 enable
   ip address virtual 192.168.250.1/24
   ipv6 address virtual 2001:DB8:D250::1/48
!
interface Vlan3009
   description MLAG_L3_VRF_VRFEXT
   no shutdown
   mtu 1500
   vrf VRFEXT
   ip address 10.255.255.104/31
!
interface Vlan3010
   description MLAG_L3_VRF_VRF-RDR
   no shutdown
   mtu 1500
   vrf VRF-RDR
   ip address 10.255.255.104/31
!
interface Vlan3011
   description MLAG_L3_VRF_VRF-CAM
   no shutdown
   mtu 1500
   vrf VRF-CAM
   ip address 10.255.255.104/31
!
interface Vlan4093
   description MLAG_L3
   no shutdown
   mtu 1500
   ip address 10.255.255.104/31
!
interface Vlan4094
   description MLAG
   no shutdown
   mtu 1500
   no autostate
   ip address 10.255.255.72/31
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |
| EVPN MLAG Shared Router MAC | mlag-system-id |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 10 | 10010 | - | - |
| 11 | 10011 | - | - |
| 12 | 10012 | - | - |
| 219 | 10219 | - | - |
| 220 | 10220 | - | - |
| 250 | 10250 | - | - |
| 3401 | 13401 | - | - |
| 3402 | 13402 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Overlay Multicast Group to Encap Mappings |
| --- | --- | ----------------------------------------- |
| VRF-CAM | 12 | - |
| VRF-RDR | 11 | - |
| VRFEXT | 10 | - |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description acc-leaf2-1_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 10 vni 10010
   vxlan vlan 11 vni 10011
   vxlan vlan 12 vni 10012
   vxlan vlan 219 vni 10219
   vxlan vlan 220 vni 10220
   vxlan vlan 250 vni 10250
   vxlan vlan 3401 vni 13401
   vxlan vlan 3402 vni 13402
   vxlan vrf VRF-CAM vni 12
   vxlan vrf VRF-RDR vni 11
   vxlan vrf VRFEXT vni 10
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: 02:1c:73:00:00:99

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address 02:1c:73:00:00:99
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | False |
| VRF-CAM | True |
| VRF-RDR | True |
| VRFEXT | True |

#### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
ip routing vrf VRF-CAM
ip routing vrf VRF-RDR
ip routing vrf VRFEXT
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |
| VRF-CAM | true |
| VRF-RDR | true |
| VRFEXT | true |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| MGMT | 0.0.0.0/0 | 172.22.0.1 | - | 1 | - | - | - |
| VRFEXT | 0.0.0.0/0 | 192.168.10.250 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 172.22.0.1
ip route vrf VRFEXT 0.0.0.0/0 192.168.10.250
```

### Router BGP

ASN Notation: asplain

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65105 | 10.255.1.5 |

| BGP Tuning |
| ---------- |
| update wait-install |
| no bgp default ipv4-unicast |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

##### MLAG-IPv4-UNDERLAY-PEER

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Remote AS | 65105 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.255.1.1 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.1.2 | 65102 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.202.16 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.255.202.18 | 65102 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - |
| 10.255.255.105 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | default | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.255.255.105 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | VRF-CAM | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.255.255.105 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | VRF-RDR | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |
| 10.255.255.105 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | VRFEXT | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Route-map In | Route-map Out | Peer-tag In | Peer-tag Out | Encapsulation | Next-hop-self Source Interface |
| ---------- | -------- | ------------ | ------------- | ----------- | ------------ | ------------- | ------------------------------ |
| EVPN-OVERLAY-PEERS | True | - | - | - | - | default | - |

#### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 10 | 10.255.1.5:10010 | 10010:10010 | - | - | learned |
| 11 | 10.255.1.5:10011 | 10011:10011 | - | - | learned |
| 12 | 10.255.1.5:10012 | 10012:10012 | - | - | learned |
| 219 | 10.255.1.5:10219 | 10219:10219 | - | - | learned |
| 220 | 10.255.1.5:10220 | 10220:10220 | - | - | learned |
| 250 | 10.255.1.5:10250 | 10250:10250 | - | - | learned |
| 3401 | 10.255.1.5:13401 | 13401:13401 | - | - | learned |
| 3402 | 10.255.1.5:13402 | 13402:13402 | - | - | learned |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | Graceful Restart |
| --- | ------------------- | ------------ | ---------------- |
| VRF-CAM | 10.255.1.5:12 | connected | - |
| VRF-RDR | 10.255.1.5:11 | connected | - |
| VRFEXT | 10.255.1.5:10 | connected<br>static | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65105
   router-id 10.255.1.5
   update wait-install
   no bgp default ipv4-unicast
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65105
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description acc-leaf2-2
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor 10.255.1.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.1.1 remote-as 65101
   neighbor 10.255.1.1 description rz-spine1_Loopback0
   neighbor 10.255.1.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.1.2 remote-as 65102
   neighbor 10.255.1.2 description rz-spine2_Loopback0
   neighbor 10.255.202.16 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.202.16 remote-as 65101
   neighbor 10.255.202.16 description rz-spine1_Ethernet3
   neighbor 10.255.202.18 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.202.18 remote-as 65102
   neighbor 10.255.202.18 description rz-spine2_Ethernet3
   neighbor 10.255.255.105 peer group MLAG-IPv4-UNDERLAY-PEER
   neighbor 10.255.255.105 description acc-leaf2-2_Vlan4093
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan 10
      rd 10.255.1.5:10010
      route-target both 10010:10010
      redistribute learned
   !
   vlan 11
      rd 10.255.1.5:10011
      route-target both 10011:10011
      redistribute learned
   !
   vlan 12
      rd 10.255.1.5:10012
      route-target both 10012:10012
      redistribute learned
   !
   vlan 219
      rd 10.255.1.5:10219
      route-target both 10219:10219
      redistribute learned
   !
   vlan 220
      rd 10.255.1.5:10220
      route-target both 10220:10220
      redistribute learned
   !
   vlan 250
      rd 10.255.1.5:10250
      route-target both 10250:10250
      redistribute learned
   !
   vlan 3401
      rd 10.255.1.5:13401
      route-target both 13401:13401
      redistribute learned
   !
   vlan 3402
      rd 10.255.1.5:13402
      route-target both 13402:13402
      redistribute learned
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf VRF-CAM
      rd 10.255.1.5:12
      route-target import evpn 12:12
      route-target export evpn 12:12
      router-id 10.255.1.5
      update wait-install
      neighbor 10.255.255.105 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.255.105 description acc-leaf2-2_Vlan3011
      redistribute connected route-map RM-CONN-2-BGP-VRFS
   !
   vrf VRF-RDR
      rd 10.255.1.5:11
      route-target import evpn 11:11
      route-target export evpn 11:11
      router-id 10.255.1.5
      update wait-install
      neighbor 10.255.255.105 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.255.105 description acc-leaf2-2_Vlan3010
      redistribute connected route-map RM-CONN-2-BGP-VRFS
   !
   vrf VRFEXT
      rd 10.255.1.5:10
      route-target import evpn 10:10
      route-target export evpn 10:10
      router-id 10.255.1.5
      update wait-install
      neighbor 10.255.255.105 peer group MLAG-IPv4-UNDERLAY-PEER
      neighbor 10.255.255.105 description acc-leaf2-2_Vlan3009
      redistribute connected route-map RM-CONN-2-BGP-VRFS
      redistribute static
```

## BFD

### Router BFD

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 300 | 300 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 300 min-rx 300 multiplier 3
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.1.0/24 eq 32 |
| 20 | permit 10.255.2.0/27 eq 32 |

##### PL-MLAG-PEER-VRFS

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.255.104/31 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.255.1.0/24 eq 32
   seq 20 permit 10.255.2.0/27 eq 32
!
ip prefix-list PL-MLAG-PEER-VRFS
   seq 10 permit 10.255.255.104/31
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

##### RM-CONN-2-BGP-VRFS

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | ip address prefix-list PL-MLAG-PEER-VRFS | - | - | - |
| 20 | permit | - | - | - | - |

##### RM-MLAG-PEER-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | origin incomplete | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
!
route-map RM-CONN-2-BGP-VRFS deny 10
   match ip address prefix-list PL-MLAG-PEER-VRFS
!
route-map RM-CONN-2-BGP-VRFS permit 20
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |
| VRF-CAM | enabled |
| VRF-RDR | enabled |
| VRFEXT | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance MGMT
!
vrf instance VRF-CAM
!
vrf instance VRF-RDR
!
vrf instance VRFEXT
```
