#!/bin/bash

# TODO:
# - Redirect all web requests to bartendro interface
# - Resolv.conf points to localhost. What should it be?
# - Change permissions on the stuff in the bartendro user

apt-get install -y --no-install-recommends dnsmasq hostapd nginx uwsgi uwsgi-plugin-python \
    python-dev python-smbus

pip install -r /home/bartendro/bartendro/ui/requirements.txt

hostname bartendro

# install the network/wifi setup files
cp -v files/dnsmasq.conf /etc
cp -v files/hostapd.conf /etc/hostapd/hostapd.conf
cp -v files/hostapd-default /etc/default/hostapd
cp -v files/hosts /etc/hosts
cp -v files/interfaces /etc/network/interfaces
cp -v files/iptables.rules /etc/iptables.rules
cp -v files/rc.local /etc/rc.local
cp -v files/dhcpcd.conf /etc
cp -v files/hostname /etc
cp -v files/sysctl.conf /etc

# create the bartendro user if need be
if [[ ! -d "/home/bartendro" ]]; then
    sudo adduser -gecos 'Bartendro' --disabled-password bartendro
    sudo adduser bartendro sudo 
    echo 'bartendro:hackme!' | sudo chpasswd
fi

# check out bartendro source
if [[ ! -d "/home/bartendro/bartendro" ]]; then
    git clone https://github.com/partyrobotics/bartendro.git /home/bartendro/bartendro
    cp /home/bartendro/bartendro/ui/bartendro.db.default /home/bartendro/bartendro/ui/bartendro.db
    chown -R bartendro:bartendro /home/bartendro
fi

# configure nginx & uwsgi
cp -v files/nginx-default /etc/nginx/sites-available/default
cp -v files/bartendro.ini /etc/uwsgi/apps-available
ln -fs /etc/uwsgi/apps-available/bartendro.ini /etc/uwsgi/apps-enabled/bartendro.ini 