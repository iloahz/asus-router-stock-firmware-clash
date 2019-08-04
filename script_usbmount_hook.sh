#!/bin/sh

sleep 10

execute_scripts() {
  sh /mnt/sda1/start-clash.sh
}

wait_until_system_ready() {
  i=0
  while [ $i -le 60 ] ; do
    success_start_service=$(nvram get success_start_service)
    if [ "$success_start_service" == "1" ] ; then
        break
    fi
    i=$(($i+1))
    sleep 1
  done
}

wait_until_iptables_up() {
  while ! iptables -L | grep -lq INPUT ; do
    sleep 1
  done
}

wait_until_network_up() {
  sleep 10
}

wait_until_system_ready
wait_until_iptables_up
wait_until_network_up
execute_scripts
