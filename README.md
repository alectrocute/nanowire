### "What is this?"

If you don't know right off the bat, then disregard this entire repo. It's a work in progress. :(


### Notes

Currently supported: rp0w

Any instance of `nanowire`, `nanowire.local` is a placeholder domain, as is the project name itself.

### Installation

Modify, apply `wpa_supplicant.conf` and blank file `ssh` to boot filesystem before first boot.

Boot device and connect via SSH.

Grab configuration script and execute (change out parameters in bash command, wifiName and wifiPass would mirror your settings in `wpa_supplicant.conf`, usually & set apName and apPass to whatever you desire) -

`curl https://raw.githubusercontent.com/alectrocute/nanowire/master/configure | bash -s -- -a apName apPass -c wifiName wifiPass`

For some reason, cron failed the first time I ran the command. You may need to run the identical command twice for some odd reason.

You should now be able to connect to the new wifi network named and protected after your apName and apPass parameter respectively. It should pass through your traffic to the client network, and `192.168.10.1` or `http://nanowire.local` should return the nginx default page. The device should be accessible via client-side (eg. `ssh pi@192.168.1.177` while connected to your home firewall router) or AP-side (`ssh pi@192.168.10.1`).

### Post-install Notes

ipv6 bug from hereonout with Jessie Lite, need to setup ipv6 forwarding...

`echo 'Acquire::ForceIPv4 "true";' | sudo tee /etc/apt/apt.conf.d/99force-ipv4`
