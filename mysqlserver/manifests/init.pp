class mysqlserver {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      exec { 'getmysql':
        cwd => '/var/tmp', # the directory to download into 
        command => 'wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm', # the download command and url
        onlyif => 'test ! -f /usr/share/mysql/english/errmsg.sys', # do not download if mysql-server is present already - no need
        path => '/usr/bin', # the path to wget
      }

      package { 'mysql57-community-release.noarch':
	provider => 'rpm',
        ensure => 'installed',
        source => '/var/tmp/mysql57-community-release-el7-11.noarch.rpm',
        require => Exec['getmysql'], # Ensure the package is downloaded first
      }

      package { 'mysql-community-server.x86_64':
        ensure => 'installed',
        require => Package['mysql57-community-release.noarch'], # Ensure the package is present first
      }

      service { 'mysqld':
        ensure => 'running', # ensures the service is running
        enable => true, # ensures the service starts at boot
        require => Package['mysql-community-server.x86_64'],
      }
    }

    'Debian':{ # alternative for Debian
      package { 'mysql-server':
        ensure => 'latest',
      }
    }

  }



}
