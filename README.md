# bartendro-config

Deployment script for bartendro. One script should install everything needed.
IMPORTANT: It is important to reboot right after the raspi-config command!

Download and write the Raspberry Pi OS Lite to an SD Card:
   
   https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip

Boot the RPi and then log in as user 'pi' with password 'raspberry'. Then:

Run raspi-config:
* Expand the filesystem
* Set the hostname to bartendro
* Set the Wifi Country and give a dummy wifi login
* Advanced: Disable console on serial port, enable serial port
* Advanced: Enable I2C

Finish raspi-config by allowing it to reboot. 

Once the RPi comes back up, log in again and follow these steps:

```
apt-get update
apt-get install git
git clone https://github.com/mayhem/bartendro-config.git
cd bartendro-config
sudo install.sh
```

During the package install step, it will ask two questions about firewall files. Answer both with YES.

Once done rebooting, log into the RPi with user 'bartendro' and password 'hackme!'. 
Finally:

    sudo deluser --force --remove-home --remove-all-files pi

From now you can no longer log in with the standard bartendro user with password "hackme!"

In theory that should be it. Your SD card should be ready to rock.
