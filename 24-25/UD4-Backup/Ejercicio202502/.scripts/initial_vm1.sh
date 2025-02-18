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
sudo apt-get install -y apache2 mariadb-server php php-cli php-mysqli php-common php-mbstring php-xml php-curl php-zip php-gd php-intl php-bcmath php-mysql unzip composer


# Creación de la base de datos y usuario en MariaDB
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET $DB_CHARSET;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST';"
sudo mysql -e "FLUSH PRIVILEGES;"

WP_OWNER=www-data
WP_GROUP=www-data
WP_ROOT=/var/www/html
WS_GROUP=www-data 
DB_NAME='salmedina_db'
DB_USER='salmedina_user'
DB_PASSWORD='salmedina_pass'
DB_HOST='localhost'
DB_CHARSET='utf8mb4'


curl --output-dir /tmp/ -O https://wordpress.org/latest.zip 
unzip /tmp/latest.zip -d ${WP_ROOT}
mv -i ${WP_ROOT}/wordpress/{.,}* ${WP_ROOT}/
rmdir ${WP_ROOT}/wordpress
rm /tmp/latest.zip

sudo cp $WP_ROOT/wp-config-sample.php $WP_ROOT/wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" $WP_ROOT/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" $WP_ROOT/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" $WP_ROOT/wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" $WP_ROOT/wp-config.php

sudo find ${WP_ROOT} -exec chown ${WP_OWNER}:${WP_GROUP} {} \;
sudo find ${WP_ROOT} -type d -exec chmod 755 {} \;
sudo find ${WP_ROOT} -type f -exec chmod 644 {} \;

sudo chgrp ${WS_GROUP} ${WP_ROOT}/wp-config.php
sudo chmod 660 ${WP_ROOT}/wp-config.php

sudo find ${WP_ROOT}/wp-content -exec chgrp ${WS_GROUP} {} \;
sudo find ${WP_ROOT}/wp-content -type d -exec chmod 775 {} \;
sudo find ${WP_ROOT}/wp-content -type f -exec chmod 664 {} \;

sudo systemctl restart apache2