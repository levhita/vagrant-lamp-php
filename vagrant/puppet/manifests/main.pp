class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
}

class othertools {
    package { "git":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "vim-common":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "curl":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

}

class server {
    package { "lamp-server^":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }
    package { "php5-mcrypt":
        ensure => latest,
        require => Package["lamp-server^"]
    }
    package { "php5-curl":
        ensure => latest,
        require => Package["lamp-server^"]
    }
}

include apt_update
include othertools
include server