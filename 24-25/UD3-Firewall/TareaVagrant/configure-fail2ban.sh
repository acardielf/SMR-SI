#!/bin/bash

sudo cp /vagrant/jail.local /etc/fail2ban/
sudo cp /vagrant/apache-limit-request.conf /etc/fail2ban/filter.d/

sudo systemctl restart fail2ban
sudo fail2ban-client reload