#!/bin/sh

create_iptables_rules() {
  if ! /usr/sbin/iptables -L -n -t nat | grep -lq CLASH ; then
    /usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 22 -j ACCEPT
    /usr/sbin/iptables -t nat -N CLASH
    /usr/sbin/iptables -t nat -A CLASH -p tcp --dport 15643 -j RETURN
    /usr/sbin/iptables -t nat -A CLASH -d 192.168.0.0/16 -j RETURN
    /usr/sbin/iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports 9090
    /usr/sbin/iptables -t nat -A PREROUTING -j CLASH
    /usr/sbin/iptables -t nat -A PREROUTING -p udp -m udp --dport 53 -j DNAT --to-destination 192.168.50.1:12358
  fi
}

start_clash() {
  killall clash-linux-armv8
  nohup /mnt/sda1/clash-linux-armv8 -d /mnt/sda1/ > /mnt/sda1/nohup.out &
}

create_iptables_rules
start_clash
