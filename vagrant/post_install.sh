#!/bin/bash
#Reconfigure locales (For PERL errors)
sudo sh -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment'
sudo sh -c 'echo "LANG=en_US.UTF-8" >> /etc/environment'
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales

#Install and enable missing mods
sudo a2enmod rewrite
sudo php5enmod mcrypt


#Allows to connect from the Host to the VM's MySQL server
sudo sed -i 's/bind-address.*/bind-address            = 0.0.0.0/' /etc/mysql/my.cnf


mysql -u root << END
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant123';
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant123';
GRANT ALL ON *.* TO 'vagrant'@'localhost';
GRANT ALL ON *.* TO 'vagrant'@'%';
END

#Turns on display errors on php for development
sudo sed -i 's/display_errors = .*/display_errors = On/' /etc/php5/apache2/php.ini

#Turns sets "AllowOverride All" for /var/www/
sudo sed -i 's/AllowOverride .*/AllowOverride All/' /etc/apache2/apache2.conf

#Final Restart
sudo service mysql restart
sudo service apache2 restart



