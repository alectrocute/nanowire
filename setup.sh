# #
# config
# #

# mac address of usb wifi dongle
apMAC="00:00:00:00:00:00"
apDriver="n180211"
apSSID="nanoWire"
apPass="raspberry"


# #
# start setup
# #

echo "starting setup!"

# update repo's
echo "updating raspi repositories..."
sudo apt-get -y update > /dev/null 2>&1
sudo apt-get -y upgrade > /dev/null 2>&1
sudo apt-get -y install sed wget nano > /dev/null 2>&1

# get firmware for wifi dongle (if realtek, etc.)
echo "installing firmware for wifi dongle if needed..."
sudo wget http://www.fars-robotics.net/install-wifi -O /usr/bin/install-wifi > /dev/null 2>&1
sudo chmod +x /usr/bin/install-wifi > /dev/null 2>&1
echo "install-wifi output:"
echo ""
sudo install-wifi
echo ""

# assign wap0 and prevent link rot
echo "preventing link rot (add iface wap0 & assign ${apMAC})..."
sudo tee /etc/udev/rules.d/70-my_network_interfaces.rules <<EOF
# prevent link rot
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="${apMAC}", NAME="wap0"
EOF

# install required packages for basic networking
echo "installing basic networking packages..."
sudo apt-get -y install hostapd dnsmasq > /dev/null 2>&1

# get wap0 out of system pipeline
echo "adding denyinterfaces line to dhcpcd config"
sudo sed -i 'denyinterfaces wap0' /etc/dhcpcd.conf > /dev/null 2>&1

# build interfaces file
echo "building system interfaces config..."
sudo cp -f /etc/network/interfaces ./interfaces

# build hostapd
echo "building hostapd config..."
sudo tee /etc/hostapd/hostapd.conf <<EOF
interface=wap0
driver=${apDriver}
ssid=${apSSID}
hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_passphrase=${apPass}
rsn_pairwise=CCMP
EOF

# add new hostapd config to daemon
echo "adding new config file to hostapd settings..."
sudo sed -i -e 's!#DAEMON_CONF=""!DAEMON_CONFIG="/etc/hostapdhostapd.conf"!g' /etc/default/hostapd

# build dnsmasq config
echo "building dnsmasq config..."
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.old
sudo tee /etc/dnsmasq.conf <<EOF
interface=wap0
listen-address=192.168.5.1
bind-interfaces
server=1.1.1.1
domain-needed
bogus-priv
dhcp-range=192.168.5.100,192.168.5.200,24h
EOF

# enable ipv4 forwarding
echo "enabling ipv4 forwarding"
sudo sed -i -e 's!#net.ipv4.ip_forward=1!net.ipv4.ip_forward=1!g' /etc/sysctl.conf

# build iptables
echo "adding firewall rules..."
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o wap0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wap0 -o wlan0 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo sed -i '/exit 0/i \
iptables-restore < /etc/iptables.ipv4.nat \
  ' inputfile

# reboot devicee
echo "going down for reboot NOW!"
sudo reboot
