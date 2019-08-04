# asus-router-stock-firmware-clash
Install clash on asus router with stock firmware

# Why
1. Stick with stock firmware! No Asuswrt-Merlin, no KoolShare.
2. Need [clash](https://github.com/Dreamacro/clash)

This repo is barely a message to give you confidence that this is feaible.

# Steps
## Enable ssh/jffs
https://github.com/gygy/asus_factory_image

## Enable usb
https://github.com/RMerl/asuswrt-merlin/wiki/Disk-formatting

## Install clash
Download binary from https://github.com/Dreamacro/clash/releases, put it under usb disk.

***Up to here, should be able to run clash on router.***

## Configure iptables
Refer to [start-clash.sh](./start-clash.sh)

`iptables -t nat -A CLASH -p tcp --dport 15643 -j RETURN` is meant to bypass clash for traffic to your proxy server, in my case all the servers are using port `15643` so the rule looks like this, you'll need to figure proper rule for your servers.  
`iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports 9090` is meant to redirect traffic to clash, so `9090` should be the port you configured in `redir-port`.
`iptables -t nat -A PREROUTING -p udp -m udp --dport 53 -j DNAT --to-destination 192.168.50.1:12358` is meant to let clash handle all dns traffic, `12358` needs to be aligned with the config in `dns` -> `listen`, if you don't have the DNS poisoning issue, you can remove this rule.

## Auto start
https://www.snbforums.com/threads/is-there-a-clear-guide-how-to-run-custom-scripts-on-stock-firmware.48512/

Refer to [script_usbmount_hook.sh](./script_usbmount_hook.sh)

***Now, transparent proxy is enabled.***

# Tags
华硕，路由器，原生固件，原厂固件
