### Notes

Currently supported: rp0w

### Installation

Modify, apply `wpa_supplicant.conf` and blank file `ssh` to boot filesystem before first boot.

Boot device and connect via SSH.

Grab configuration script and execute (change out parameters in bash command) -

`curl https://raw.githubusercontent.com/alectrocute/nanowire/master/configure | bash -s -- -a MyAP myappass -c WifiSSID wifipass`

### Possible next steps (WIP)

ipv6 bug from hereonout with Jessie Lite, need to setup ipv6 forwarding...

`echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4`

`sudo apt-get install nginx -y`

`sudo nano /etc/dnsmasq.conf`

Add the following line:

`addn-hosts=/etc/dnsmasq.hosts`
