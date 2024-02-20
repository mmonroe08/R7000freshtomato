modprobe wireguard
ip link add dev wg0 type wireguard
ip address add dev wg0 10.7.0.2/32
/bin/cat << EOF > /mnt/wg0.conf

[Interface]
PrivateKey = SElck4VwUos0hyXKHxxxxxxxxF6+RIHb9lM9Hgx0Y1g=

[Peer]
PublicKey = rfA0YJAnSgeHsVcBxxxxxxxxs9ePWpa8s9TSK5wWMl0=
AllowedIPs = 0.0.0.0/0
Endpoint = 47.xx.xx.2:PORT
PersistentKeepalive = 25


cat /mnt/wg0.conf
/usr/sbin/wg setconf wg0 /mnt/wg0.conf

/usr/sbin/wg
sleep 25
ip link set up dev wg0
wg show wg0
ip route add 0.0.0.0/1 dev wg0
ip route add 128.0.0.0/1 dev wg0
ip route add 47.xx.xx.2/32 via 10.x.128.1 dev ppp0
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

#end

# configure routes

#ip link set down dev wg0
# ip route del 0.0.0.0/1 dev wg0
# ip route del 128.0.0.0/1 dev wg0
# ip route del 8.208.x.x/32 via 10.x.128.1 dev ppp0
