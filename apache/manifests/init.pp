class apache {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      package { 'httpd':
        ensure => 'latest',
      }

      file { 'httpdconf':
        ensure  => 'file',
        path    => '/etc/httpd/conf/httpd.conf',
        require => Package['httpd'],
      }

      file { 'httpdroot':
        ensure => 'exists',
        path   => '/var/www/s3627699/',
      }

      service { 'httpd':
#        ensure => 'running',
#        enable => true,
        require   => File['httpdconf'],
        subscribe => File['httpdconf'],
      }

      exec { 'httpdsetup':
        cwd     => '/etc/httpd/conf/',
        command => 'sed -i "s#DocumentRoot \"/var/www/html#DocumentRoot \"/var/www/s3627699#" httpd.conf',
        path    => '/bin/',
        require => File['httpdroot'],
        unless  => '/bin/cat /etc/httpd/conf/httpd.conf | /bin/grep s3627699',
      }

    }

    'Debian':{ # alternative for Debian
      package { 'apache2':
        ensure => 'latest',
      }
    }

  }
}

