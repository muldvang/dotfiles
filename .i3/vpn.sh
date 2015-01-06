#!/usr/bin/fish

ip link | grep tun > /dev/null
if test $status -eq 0
    echo "VPN"
end
