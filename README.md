# bartendro-config

Deployment script for bartendro. One script should install everything needed.

- Download and write latest Raspian distro to an SD Card
- Run first use setup (raspi-config):
        Enable the serial port
            Expand the filesystem
            Enable I2C
        - Then reboot

Then log into the RPi as user 'pi' with password 'raspberry'. Then follow these steps:

```
sudo su - 
git clone --recursive https://github.com/mayhem/bartendro-config.git
cd bartendro-config
sudo sh install.sh
sudo reboot
```

Once done rebooting, log into the RPi with user 'bartendro' and password 'hackme!'. Then

    sudo rmuser pi

In theory that should be it. Your SD card should be ready to rock.
