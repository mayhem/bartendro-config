# bartendro-config

Deployment script for bartendro. One script should install everything needed.

Download and write latest Raspian distro to an SD Card. Boot the RPi and then log in 
as user 'pi' with password 'raspberry'. Then:

```
git clone https://github.com/mayhem/bartendro-config.git
cd bartendro-config
sudo sh install.sh
```

Next, run raspi-config:
* Expand the filesystem
* Advanced: Disable console on serial port
* Advanced: Enable I2C

Finish raspi-config by allowing it to reboot. Once done rebooting, log into the RPi with 
user 'bartendro' and password 'hackme!'. Then

    sudo rmuser pi

In theory that should be it. Your SD card should be ready to rock.
