modprobe wireguard
ip link add dev wg0 type wireguard
ip address add dev wg0 172.16.1.2/32
/bin/cat << EOF > /mnt/wg0.conf

[Interface]
ListenPort = 51820
PrivateKey= mH9sW6XoKuxxxxxxxxxxxxxxxxxxxxL6cgh+FiHs=
[Peer]
PublicKey= A5L0CAw9/iqWxxxxxxxxxxxxxxxxx6bLLXHAT9c6zAE=
Endpoint = xx.xx.xx.xx:10000
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
eval "ip route add xx.xx.xx.xx/32 $(ip route show default 0.0.0.0/0 | sed 's/default //')" dev ppp0
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
