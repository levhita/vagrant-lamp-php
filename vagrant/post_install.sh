#!/bin/bash

#Reconfigure locales (For PERL errors)
sudo sh -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment'
sudo sh -c 'echo "LANG=en_US.UTF-8" >> /etc/environment'
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales

#Install and enable missing mods
sudo a2enmod rewrite
sudo a2enmod speling
sudo php5enmod mcrypt

#Turns on display_errors on PHP for development
sudo sed -i 's/display_errors = .*/display_errors = On/' /etc/php5/apache2/php.ini

#Turns on short_open_tag (<?=?>, <??>)
sudo sed -i 's/short_open_tag = .*/short_open_tag = On/' /etc/php5/apache2/php.ini

#MySQL user for external access
mysql -u root <<ENDSTRING
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant123';
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant123';
GRANT ALL ON *.* TO 'vagrant'@'localhost';
GRANT ALL ON *.* TO 'vagrant'@'%';
ENDSTRING

#Allows to connect from the Host to the VM's MySQL server
sudo sed -i 's/bind-address.*/bind-address            = 0.0.0.0/' /etc/mysql/my.cnf
sudo service mysql restart

#Create folder for Entryless
sudo mkdir -p /var/www/entryless

#Create site config
sudo sh -c "cat >> /etc/apache2/sites-available/entryless.conf" <<ENDSTRING
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/entryless
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<Directory /var/www/entryless>
        Options Indexes FollowSymLinks
        AllowOverride All
        IndexIgnore *
        Order allow,deny
        Allow from all
        Require all granted
        RewriteEngine on
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteCond %{REQUEST_FILENAME}.php -f
        RewriteRule ^(.+)$ /.php [L,QSA]

        CheckSpelling On
        CheckCaseOnly On
</Directory>
ENDSTRING

#Remove default apache config
sudo rm /etc/apache2/sites-enabled/000-default.conf

#Enable cite config
sudo a2ensite entryless.conf

#Turns sets "AllowOverride All" for /var/www/
sudo sed -i 's/AllowOverride .*/AllowOverride All/' /etc/apache2/apache2.conf

#Restart Apache
service apache2 restart

#Create temporal volumes
sudo mkdir -p /mnt/invoice-volume
sudo chmod 777 /mnt/invoice-volume

sudo mkdir -p /mnt/invoice-temp
sudo chmod 777 /mnt/invoice-temp

sudo mkdir -p /mnt/mail-volume
sudo chmod 777 /mnt/mail-volume