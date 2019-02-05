# #
# config
# #

# mac address of usb wifi dongle
apMAC="00:00:00:00:00:00"


# #
# start setup
# #

# update repo's
echo "updating raspi repositories..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get upgrade > /dev/null 2>&1

# assign wap0 and prevent link rot
echo "preventing link rot (assign ${apMAC} to wap0)..."
sudo tee /etc/udev/rules.d/70-my_network_interfaces.rules <<EOF > /dev/null 2>&1
# prevent link rot
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="${apMAC}", NAME="wap0"
EOF

