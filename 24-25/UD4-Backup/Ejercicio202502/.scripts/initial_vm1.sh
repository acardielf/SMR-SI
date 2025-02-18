#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                                                       #
#                                                                                                                       #
# ███████╗███████╗████████╗███████╗    ███████╗██╗ ██████╗██╗  ██╗███████╗██████╗  ██████╗                              #
# ██╔════╝██╔════╝╚══██╔══╝██╔════╝    ██╔════╝██║██╔════╝██║  ██║██╔════╝██╔══██╗██╔═══██╗                             #
# █████╗  ███████╗   ██║   █████╗      █████╗  ██║██║     ███████║█████╗  ██████╔╝██║   ██║                             #
# ██╔══╝  ╚════██║   ██║   ██╔══╝      ██╔══╝  ██║██║     ██╔══██║██╔══╝  ██╔══██╗██║   ██║                             #
# ███████╗███████║   ██║   ███████╗    ██║     ██║╚██████╗██║  ██║███████╗██║  ██║╚██████╔╝                             #
# ╚══════╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝                              #
#                                                                                                                       #
# ███████╗███████╗    ██╗   ██╗███████╗                                                                                 #
# ██╔════╝██╔════╝    ██║   ██║██╔════╝                                                                                 #
# ███████╗█████╗      ██║   ██║█████╗                                                                                   #
# ╚════██║██╔══╝      ╚██╗ ██╔╝██╔══╝                                                                                   #
# ███████║███████╗     ╚████╔╝ ███████╗                                                                                 #
# ╚══════╝╚══════╝      ╚═══╝  ╚══════╝                                                                                 #
#                                                                                                                       #
# ██████╗ ███████╗██████╗  ██████╗     ███╗   ██╗ ██████╗     ███████╗███████╗    ████████╗ ██████╗  ██████╗ █████╗     #
# ██╔══██╗██╔════╝██╔══██╗██╔═══██╗    ████╗  ██║██╔═══██╗    ██╔════╝██╔════╝    ╚══██╔══╝██╔═══██╗██╔════╝██╔══██╗    #
# ██████╔╝█████╗  ██████╔╝██║   ██║    ██╔██╗ ██║██║   ██║    ███████╗█████╗         ██║   ██║   ██║██║     ███████║    #
# ██╔═══╝ ██╔══╝  ██╔══██╗██║   ██║    ██║╚██╗██║██║   ██║    ╚════██║██╔══╝         ██║   ██║   ██║██║     ██╔══██║    #
# ██║     ███████╗██║  ██║╚██████╔╝    ██║ ╚████║╚██████╔╝    ███████║███████╗       ██║   ╚██████╔╝╚██████╗██║  ██║    #
# ╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝     ╚═╝  ╚═══╝ ╚═════╝     ╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝╚═╝  ╚═╝    #
#                                                                                                                       #
#                                                                                                                       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #












sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X 


ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""


sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get install -y apache2 mariadb-server unzip php8.4 php-cli php-common php-mbstring php-xml php-curl php-zip php-gd php-intl php-bcmath php-mysql php-sqlite3 unzip composer

WP_OWNER=www-data
WP_GROUP=www-data
WP_ROOT=/var/www/html
WS_GROUP=www-data 

curl --output-dir /tmp/ -O https://wordpress.org/latest.zip 
unzip /tmp/latest.zip -d ${WP_ROOT}
mv -i ${WP_ROOT}/wordpress/{.,}* ${WP_ROOT}/
rmdir ${WP_ROOT}/wordpress
rm /tmp/latest.zip

sudo find ${WP_ROOT} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
sudo find ${WP_ROOT} -type d -exec chmod 755 {} \;
sudo find ${WP_ROOT} -type f -exec chmod 644 {} \;

sudo chgrp ${WS_GROUP} ${WP_ROOT}/wp-config.php
sudo chmod 660 ${WP_ROOT}/wp-config.php

sudo find ${WP_ROOT}/wp-content -exec chgrp ${WS_GROUP} {} \;
sudo find ${WP_ROOT}/wp-content -type d -exec chmod 775 {} \;
sudo find ${WP_ROOT}/wp-content -type f -exec chmod 664 {} \;