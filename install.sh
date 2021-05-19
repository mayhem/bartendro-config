#!/bin/bash

apt-get update
apt-get install -y --no-install-recommends hostapd isc-dhcp-server iptables-persistent dnsmasq \
    nginx uwsgi uwsgi-plugin-python python-dev python-smbus git-core python-pip python-setuptools python-wheel

# install the network/wifi setup files
install -m 440 files/sudoers /etc/sudoers.d/90-bartendro
cp -v files/dhcpd.conf /etc/dhcp/dhcpd.conf
cp -v files/isc-dhcp-server /etc/default/isc-dhcp-server
cp -v files/wlan0 /etc/network/interfaces.d
cp -v files/hostapd.conf /etc/hostapd/hostapd.conf
cp -v files/hostapd /etc/hostapd
cp -v files/dnsmasq.conf /etc/dnsmasq.conf
cp -v files/rc.local /etc/rc.local
echo "DNSMASQ_EXCEPT=lo" >> /etc/default/dnsmasq

# setup the firewall
iptables -A FORWARD -i eth0 -o wlan0 -m state --state  RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
iptables -t nat -S
sh -c "iptables-save > /etc/iptables/rules.v4"

#enable services
systemctl unmask hostapd
systemctl enable hostapd
systemctl unmask isc-dhcp-server 
systemctl enable isc-dhcp-server
systemctl unmask dnsmasq
systemctl enable dnsmasq

# create the bartendro user 
sudo adduser -gecos 'Bartendro' --disabled-password bartendro
sudo adduser bartendro sudo
echo 'bartendro:hackme!' | sudo chpasswd

# check out bartendro source
if [ ! -d "/home/bartendro/bartendro" ]; then
    git clone https://github.com/partyrobotics/bartendro.git /home/bartendro/bartendro
    cp /home/bartendro/bartendro/ui/bartendro.db.default /home/bartendro/bartendro/ui/bartendro.db
    chown -R bartendro:bartendro /home/bartendro
fi

# Install the needed python modules
pip install -r /home/bartendro/bartendro/ui/requirements.txt

# configure nginx & uwsgi
cp -v files/nginx.conf /etc/nginx
cp -v files/nginx-default /etc/nginx/sites-available/default
cp -v files/bartendro.ini /etc/uwsgi/apps-available
ln -fs /etc/uwsgi/apps-available/bartendro.ini /etc/uwsgi/apps-enabled/bartendro.ini

# change the ownership of everything in the bartendro user
chown -R bartendro:bartendro /home/bartendro

echo "Now reboot, log back in and remove the pi user with:"
echo "   sudo deluser --force --remove-home --remove-all-files pi"
