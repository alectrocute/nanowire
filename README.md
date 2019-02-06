### Notes

Currently supported: rp0w

Any instance of `nanowire.com` is a placeholder TLD, as is the project name itself.

### Installation

Modify, apply `wpa_supplicant.conf` and blank file `ssh` to boot filesystem before first boot.

Boot device and connect via SSH.

Grab configuration script and execute (change out parameters in bash command, wifiName and wifiPass would mirror your settings in `wpa_supplicant.conf`, usually & set apName and apPass to whatever you desire) -

`curl https://raw.githubusercontent.com/alectrocute/nanowire/master/configure | bash -s -- -a apName apPass -c wifiName wifiPass`

### Post-install Notes

ipv6 bug from hereonout with Jessie Lite, need to setup ipv6 forwarding...

`echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4`
