modprobe wireguard
ip link add dev wg0 type wireguard
ip address add dev wg0 10.7.0.2/32
/bin/cat << EOF > /mnt/wg0.conf

[Interface]
ListenPort = 51820
PrivateKey = eHjwIsy/goFf=

[Peer]
PublicKey = GrJk/5LB0eXRsOsntWg=
PresharedKey = yUXD4lW+o5MHkvoA1YhZS0=
Endpoint = 8.xx:51820
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
ip route add 8.xx/32 via 39.65.220.1 dev ppp0
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

#end
