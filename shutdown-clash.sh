#!/bin/sh

clear_iptables_rules() {
  if /usr/sbin/iptables -L -n -t nat | grep -lq CLASH ; then
    /usr/sbin/iptables -t nat -D PREROUTING -p tcp --dport 22 -j ACCEPT
  	/usr/sbin/iptables -t nat -D PREROUTING -j CLASH
  	/usr/sbin/iptables -t nat -F CLASH
  	/usr/sbin/iptables -t nat -X CLASH
  	/usr/sbin/iptables -t nat -D PREROUTING -p udp -m udp --dport 53 -j DNAT --to-destination 192.168.50.1:12358
  fi
}

kill_clash() {
  killall clash-linux-armv8
}

clear_iptables_rules
kill_clash
