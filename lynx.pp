class lynx{
  case $::operatingsystem {
    'RedHat': { # if the operating system is RedHat
      exec { 'yum-config':
        command => '/usr/bin/yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional', # update the yum config manager to allow installation of lynx
        creates => '/usr/bin/lynx', # execute only if lynx is not installed
      }

      package { 'lynx':
        ensure => 'latest',
        require => Exec['yum-config'], # require the yum-config exec before the package can be installed
      }
    }

    'Debian':{ # alternative for Debian
      package { 'lynx':
        ensure => 'latest',
      }
    }

  }
}
