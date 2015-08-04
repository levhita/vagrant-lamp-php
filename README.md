<h1>Vagrant and Puppet configuration for Lamp with PHP</h1>

Vagrant configuration with puppet to create a Virtual Box machine with 
Ubuntu Server 14.04, Lamp / PHP

<h2>installation:</h2>

<h3>Linux</h3>
* Install Vagrant and Virtualbox
```
sudo apt-get install virtualbox vagrant
```

* Clone the repository:
```
git clone -b entryless_web git://github.com/levhita/vagrant-lamp-php.git
```
<h3>Mac and Windows</h3>
* Donwload and Install Vagrant: http://www.vagrantup.com/downloads
* Download and Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
* Clone the repository:
```
git clone -b entryless_web git://github.com/levhita/vagrant-lamp-php.git
```

**running:**

* Run VM (the first time the VM will be created).
```
vagrant up
```
* Login into the VM
```
vagrant ssh
```
* Stop the VM
```
vagrant halt
```



**development:**

* You have a shared folder at *www* for your */var/www*
* And an extra folder at *home* for *vagrant*
* Server is availabe at http://localhost:5000/
* IP of the server is 192.168.33.10
* You can connect to MySQL at 192.168.33.10, Using user "vagrant" and password "vagrant123"

**Puppet Manifest will install:**

* wget
* git
* vim
* g++
* LAMP
* PHP5



Good hacking!!!!!!!!
