#!/bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -A FORWARD -o tun0 -i eth0 -s 10.0.75.0/24 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A POSTROUTING -t nat -j MASQUERADE
iptables-save | tee /etc/iptables.sav
