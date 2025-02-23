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

wp() {
    sudo -u www-data /usr/local/bin/wp --path=${WP_ROOT} "$@"
}











sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X 


ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""


sudo apt-get install -y apache2 mariadb-server php php-cli php-common php-mbstring php-xml php-curl php-zip php-gd php-intl php-bcmath php-mysql unzip composer


WP_OWNER=www-data
WP_GROUP=www-data
WP_ROOT=/var/www/html
WS_GROUP=www-data 
DB_NAME='salmedina_db'
DB_USER='salmedina_user'
DB_PASSWORD='salmedina_pass'
DB_HOST='localhost'
DB_CHARSET='utf8mb4'

sudo mysql -e "DROP DATABASE IF EXISTS $DB_NAME;"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET $DB_CHARSET;"
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST';"
sudo mysql -e "FLUSH PRIVILEGES;"

curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
php /usr/local/bin/wp --info

sudo rm -rf ${WP_ROOT}/*

sudo chown -R www-data:www-data ${WP_ROOT}

echo "alias wp='sudo -u www-data wp --path=${WP_ROOT}'" >> /home/vagrant/.bashrc
chown vagrant:vagrant /home/vagrant/.bashrc


echo "Downloading Wordpress..."
wp core download

echo "Creating wp-config.php..."
wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" --locale=es_ES

echo "Installing Wordpress..."
wp core install --url=192.168.56.103 --title="Salmedina SMR" --admin_user=salmedina --admin_password=salmedina --admin_email=admin@salmedina.com

echo "Installing Wordpress language..."
wp language core install es_ES

echo "Remove default content..."
wp post delete 1
wp comment delete 1 --force

echo "Creating first post..."
wp post create --post_type=post --post_title="Inicio" --post_content="Bienvenido al examen de Seguridad Informática" --post_status=publish
wp cache flush