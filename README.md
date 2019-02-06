### "What is this?"

If you don't know right off the bat, then disregard this entire repo. It's a work in progress. :(


### Notes

Currently supported: rp0w

Any instance of `nanowire`, `nanowire.local` is a placeholder TLD, as is the project name itself.

### Installation

Modify, apply `wpa_supplicant.conf` and blank file `ssh` to boot filesystem before first boot.

Boot device and connect via SSH.

Grab configuration script and execute (change out parameters in bash command, wifiName and wifiPass would mirror your settings in `wpa_supplicant.conf`, usually & set apName and apPass to whatever you desire) -

`curl https://raw.githubusercontent.com/alectrocute/nanowire/master/configure | bash -s -- -a apName apPass -c wifiName wifiPass`

For some reason, cron failed the first time I ran the command. You may need to run the identical command twice for some odd reason.

### Post-install Notes

ipv6 bug from hereonout with Jessie Lite, need to setup ipv6 forwarding...

`echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4`
