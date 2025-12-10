!
frr version 8.4_git
frr defaults traditional
hostname router
no ipv6 forwarding
!
interface eth2
 ip address 10.250.230.2/30
exit
!
interface eth3
 ip address 10.250.230.6/30
exit
!
interface eth1
 ip address 138.10.1.1/30
exit
!
interface gre1
ip address 10.250.231.1/30
exit
!
interface lo0
 ip address 10.255.1.255/32
exit
!
router bgp 65201
 bgp router-id 10.255.1.255
 neighbor ARISTAS peer-group
 neighbor 10.250.231.2 remote-as 65202
 neighbor 10.250.231.2 peer-group ARISTAS
 neighbor 10.250.230.1 remote-as 65103
 neighbor 10.250.230.1 peer-group ARISTAS
 neighbor 10.250.230.5 remote-as 65104
 neighbor 10.250.230.5 peer-group ARISTAS
 neighbor 10.250.230.9 remote-as 65109
 neighbor 10.250.230.9 peer-group ARISTAS
 neighbor 10.250.230.13 remote-as 65110
 neighbor 10.250.230.13 peer-group ARISTAS
 !
 address-family ipv4 unicast
  network 10.250.0.0/16
  redistribute connected
  neighbor ARISTAS route-map ALLOW_ALL in
  neighbor ARISTAS route-map ALLOW_ALL out
 exit-address-family
exit
!
route-map ALLOW_ALL permit 10
exit
!
end
