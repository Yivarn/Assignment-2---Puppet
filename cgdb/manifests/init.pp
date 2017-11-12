class cgdb {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      exec { 'getcgdb':
        cwd     => '/var/tmp', # the directory to download into 
        command => 'wget ftp://mirror.switch.ch/pool/4/mirror/epel/7/x86_64/Packages/c/cgdb-0.6.8-1.el7.x86_64.rpm', # the download command and url
        onlyif  => 'test ! -f /bin/cgdb', # do not download if cgdb is present already - no need
        path    => '/usr/bin', # the path to wget
      }

      package { 'cgdb':
  ensure   => 'present',
        provider => 'rpm',
        source   => '/var/tmp/cgdb-0.6.8-1.el7.x86_64.rpm',
        require  => Exec['getcgdb'], # Ensure the package is downloaded first
      }
    }

    'Debian':{ # alternative for Debian
      package { 'cgdb':
        ensure => 'latest',
      }
    }

  }
}
