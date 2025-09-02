#!/bin/bash
set -x

# Remove existing links and processes before starting a new tunnel
sudo ip link set can0 down
sudo ip link set ctun0 down
sudo killall isotptun

sudo ip link set can0 up type can bitrate 800000 dbitrate 8000000 restart-ms 100 fd on
# sudo ip link set can0 up type can bitrate 800000 dbitrate 4000000 restart-ms 100 fd on
# sudo ip link set can0 up type can bitrate 800000 dbitrate 11428571 restart-ms 100 fd on
# sudo isotptun -L 72:64:1 -b 16 -m f1 -s 7FE -d 7FF can0 -D
sudo isotptun -L 72:64:1 -b 0 -m 0 -s 7FE -d 7FF can0 -D
sleep 1s
sudo ip addr add 192.168.0.2/24 dev ctun0 ; sudo ip link set ctun0 up ; sudo ip route add default via 192.168.0.1
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
