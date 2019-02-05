# #
# config
# #

# mac address of usb wifi dongle
apMAC="00:00:00:00:00:00"


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
sudo tee /etc/udev/rules.d/70-my_network_interfaces.rules > /dev/null 2>&1 <<EOF
# prevent link rot
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="${apMAC}", NAME="wap0"
EOF

# install required packages for basic networking
echo "installing basic networking packages..."
sudo apt-get -y install hostapd dnsmasq > /dev/null 2>&1

# get wap0 out of system pipeline
sudo sed -i 'denyinterfaces wap0' /etc/dhcpcd.conf > /dev/null 2>&1

# build interfaces file
sudo cp -f /etc/network/interfaces ./interfaces
