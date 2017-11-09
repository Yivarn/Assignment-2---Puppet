class mysqlclient {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      package { 'mysql-community-client.x86_64':
        ensure => 'installed',
        require => Class['mysqlserver'], # Ensure the repo is installed
      }

    }

    'Debian':{ # alternative for Debian
      package { 'mysql-client':
        ensure => 'latest',
      }
    }

  }



}
