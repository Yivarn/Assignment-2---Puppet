class diatocode {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      exec { 'getdia2code':
        cwd => '/var/tmp', # the directory to download into 
        command => 'wget https://downloads.sourceforge.net/project/dia2code/dia2code/0.8.3/dia2code-0.8.3-1.x86_64.rpm', # the download command and url
        onlyif => 'test ! -f /bin/dia2code', # do not download if dia2code is present already - no need
        path => '/usr/bin', # the path to wget
      }

      package { 'dia2code':
	provider => 'rpm',
        ensure => 'present',
        source => '/var/tmp/dia2code-0.8.3-1.x86_64.rpm',
        require => Exec['getdia2code'], # Ensure the package is downloaded first
      }
    }

    'Debian':{ # alternative for Debian
      package { 'dia2code':
        ensure => 'latest',
      }
    }

  }
}
