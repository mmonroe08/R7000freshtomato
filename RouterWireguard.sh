
modprobe wireguard
ip link add dev wg0 type wireguard
ip address add dev wg0 10.103.251.203/32
/bin/cat << EOF > /mnt/wg0.conf

[Interface]
ListenPort =  15289
PrivateKey = sG1CmFVM2pxzA7osKObrqGl+CUuehvDVSjE21lij8UI=

[Peer]
PublicKey = Zhvg9EBQgoLKjsMWV0jT2TVtFlfXKYN1X7tafzXFdRo=
PresharedKey = DF0KVBBL+e9OkAhIjQvilP8NdRxBWwc6GsyVk8fuk5U=
Endpoint = 38.145.197.21:15289
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25


EOF
cat /mnt/wg0.conf
/usr/sbin/wg setconf wg0 /mnt/wg0.conf

/usr/sbin/wg
sleep 25
ip link set up dev wg0
wg show wg0
ip route add 0.0.0.0/1 dev wg0
ip route add 128.0.0.0/1 dev wg0
eval "ip route add ip/32 $(ip route show default 0.0.0.0/0 | sed 's/default //')" dev ppp0
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
