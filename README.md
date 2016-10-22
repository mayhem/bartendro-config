# bartendro-config

Deployment script for bartendro. One script should install everything needed.
IMPORTANT: It is important to reboot right after the raspi-config command!

Download and write the 2016-05-27 Raspian Jessie-list distro to an SD Card: 

  https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2016-05-31/2016-05-27-raspbian-jessie-lite.zip

Boot the RPi and then log in as user 'pi' with password 'raspberry'. Then:

Run raspi-config:
* Expand the filesystem
* Startup: Boot into console, require password
* Advanced: Disable console on serial port
* Advanced: Enable I2C

Finish raspi-config by allowing it to reboot. 

Once the RPi comes back up, log in again and follow these steps:

```
apt-get update
apt-get install git
git clone https://github.com/mayhem/bartendro-config.git
cd bartendro-config
sudo sh install.sh
```

Once done rebooting, log into the RPi with user 'bartendro' and password 'hackme!'. 
Finally:

    sudo deluser --force --remove-home --remove-all-files pi

From now you can no longer log in with the standard pi user. 

In theory that should be it. Your SD card should be ready to rock.
