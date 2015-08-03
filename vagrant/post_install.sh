#!/bin/bash

#Reconfigure Locales (For PERL errors)
/etc/environment
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "LANG=en_US.UTF-8" >> /etc/environment
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales

#Install and Enable missing mods
sudo apt-get install php5-mcrypt
sudo apt-get install php5-curl
sudo a2enmod rewrite
sudo a2enmod speling
sudo php5enmod mcrypt

#Turns on display errors on php for development
sudo sed -i 's/display_errors = .*/display_errors = On/' /etc/php5/apache2/php.ini

#Turns on short open tags
sudo sed -i 's/short_open_tag = .*/short_open_tag = On/' /etc/php5/apache2/php.ini
sudo service apache2 restart

#Mysql user for external access
mysql -u root << ENDSTRING
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

#Create Site Config
sudo sh -c "cat >> /etc/apache2/sites-available/entryless.conf" <<-ENDSTRING
<Directory /var/www/entryless>
	Options Indexes
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
	RewriteRule ^(.+)$ /$1.php [L,QSA] 

	CheckSpelling On
	CheckCaseOnly On
</Directory>
ENDSTRING

#Enable Site Config
sudo a2ensite entryless.conf

#Restart Apache
service apache2 restart

#Create temporal volumes
sudo mkdir -p /mnt/invoice-volume
sudo chmod 777 /mnt/invoice-volume

sudo mkdir -p /mnt/invoice-temp
sudo chmod 777 /mnt/invoice-temp

sudo mkdir -p /mnt/mail-volume
sudo chmod 777 /mnt/mail-volume

#Must be edited manually later!!
touch /www/entryless/config.php