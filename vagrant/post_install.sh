#!/bin/bash
#Turns on display errors on php for development
sudo sed -i 's/display_errors = .*/display_errors = On/' /etc/php5/apache2/php.ini
sudo service apache2 restart
#Allows to connect from the Host to the VM's MySQL server
sudo sed -i 's/bind-address.*/bind-address            = 0.0.0.0/' /etc/mysql/my.cnf
sudo service mysql restart

mysql -u root << END
CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant123';
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant123';
GRANT ALL ON *.* TO 'vagrant'@'localhost';
GRANT ALL ON *.* TO 'vagrant'@'%';
END