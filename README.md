Modify, apply `wpa_supplicant.conf` and blank file `ssh` to boot filesystem before first boot.

Boot device and connect via SSH.

Grab configuration script and execute (change out parameters in bash command) -

`curl https://raw.githubusercontent.com/alectrocute/nanowire/master/configure | bash -s -- -a MyAP myappass -c WifiSSID wifipass`
