#!/usr/bin/env bash


echo "================================================================================================"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Apache/PHP/Composer <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
echo "================================================================================================"


apt-get install -y apache2
apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-zip php7.0-pgsql php-xdebug
apt-get install -y composer


# Apache
vhost="
<VirtualHost *:80>
  DocumentRoot /var/www/public
  ServerName localhost
  <Directory /var/www/public>
    AllowOverride All
  </Directory>
</VirtualHost>"

echo "${vhost}" > /etc/apache2/sites-available/site_vagrant.conf

a2ensite site_vagrant.conf
a2enmod rewrite


# PHP
cd /etc/php/7.0

xdebug="
xdebug.remote_enable=1
xdebug.remote_autostart=1
xdebug.remote_port=9000
xdebug.remote_host=10.0.2.2
xdebug.idekey=\"PHPSTORM\""

echo "${xdebug}" >> mods-available/xdebug.ini

# PHP ini - Apache
sed -i 's#short_open_tag =.*#short_open_tag = On#' apache2/php.ini
sed -i 's#.*date.timezone =.*#date.timezone = "America/Sao_Paulo"#' apache2/php.ini

# PHP ini - CLI
sed -i 's#short_open_tag =.*#short_open_tag = On#' cli/php.ini
sed -i 's#.*date.timezone =.*#date.timezone = "America/Sao_Paulo"#' cli/php.ini


# restart Apache
service apache2 restart