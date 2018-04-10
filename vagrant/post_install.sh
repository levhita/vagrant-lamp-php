#!/bin/bash

#Reconfigure locales (For PERL errors)
sudo sh -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/environment'
sudo sh -c 'echo "LANG=en_US.UTF-8" >> /etc/environment'
sudo locale-gen en_US en_US.UTF-8
sudo dpkg-reconfigure locales

sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password vagrant123'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password vagrant123'
sudo apt-get -y install mysql-server-5.7


sudo apt-get -y install  lamp-server^

#Install and enable missing mods
sudo a2enmod rewrite

#Allows to connect from the Host to the VM's MySQL server
sudo sed -i 's/bind-address.*/bind-address            = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo mysql -u root -p"vagrant123"<< END
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant123';
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant123';
GRANT ALL ON *.* TO 'vagrant'@'localhost';
GRANT ALL ON *.* TO 'vagrant'@'%';
END

#Turns sets "AllowOverride All" for /var/www/
sudo sed -i 's/AllowOverride .*/AllowOverride All/' /etc/apache2/apache2.conf

#Final Restart
sudo service mysql restart
sudo service apache2 restart



