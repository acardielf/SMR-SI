#!/bin/bash

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

iptables -A INPUT -p tcp -s 8.8.8.8 --dport 80 -j REJECT
iptables -A INPUT -p tcp -s 8.8.8.8 --dport 443 -j REJECT
iptables -A INPUT -p udp --dport 53 -j REJECT
iptables -A OUTPUT -p udp --dport 2256 -j ACCEPT
iptables -A OUTPUT -p icmp -s 10.0.0.0/8 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3306 -j ACCEPT

sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP