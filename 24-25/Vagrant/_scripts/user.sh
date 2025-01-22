#!/bin/bash

# Lenguaje y teclado
sudo apt-get -y update
sudo update-locale "LANG=es_ES.UTF-8"
sudo locale-gen --purge "es_ES.UTF-8"
sudo dpkg-reconfigure --frontend noninteractive locales
sudo sed -i 's/XKBLAYOUT=\"us\"/XKBLAYOUT=\"es\"/g' /etc/default/keyboard

# Crear usuario
useradd -m -s /bin/bash user
echo "user:user" | chpasswd
usermod -aG sudo user


# Install SSH server
sudo apt-get update
sudo apt-get install openssh-server -y
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
