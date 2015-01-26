<h2>Vagrant and Puppet configuration for Lamp with PHP</h2>

Vagrant configuration with puppet to create a Virtual Box machine with 
Ubuntu Server 14.04, Lamp / PHP




**installation:**

* Install Vagrant
* Install Virtual
* Clone the repository git clone [git://github.com/levhita/vagrant-lamp-php.git](git://github.com/levhita/vagrant-lamp-php.git)


**running:**

* Run - vagrant up<br>
* SSH - vagrant ssh<br>
* Halt - vagrant halt<br>


**development:**

by default this vagrantfile have this configuration for shared folder between the host and the VM
*[config.vm.synced_folder "~/www", "/var/www"]*

Server is availabe at http://localhost:5000/


**Puppet Manifest will install:**

* wget
* git
* vim
* g++
* LAMP
* PHP5



Good hacking!!!!!!!!
