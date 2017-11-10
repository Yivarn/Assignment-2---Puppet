class vnc{

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      package { 'tigervnc-server':
        ensure => 'latest',
      }

      exec { 'setup_vnc_1':
        command => 'cp /lib/systemd/system/vncserver@.service /etc/systemd/system',
        creates => '/etc/systemd/system/vncserver@.service',
        path => '/bin/', # the path to cp
        require => Package['tigervnc-server'],
      }

      exec { 'setup_vnc_2':
        cwd => '/etc/systemd/system/',
        command => "sed -i 's/<USER>/root/' vncserver@.service",
        path => '/bin/', # the path to sed
        require => Exec['setup_vnc_1'],
        unless => '/sbin/service vncserver status',
      }

      exec { 'setup_vnc_3':
        cwd => '/etc/systemd/system/',
        command => "sed -i 's#PIDFile=/home#PIDFile=#' vncserver@.service",
        path => '/bin/', # the path to sed
        require => Exec['setup_vnc_2'],
        unless => '/sbin/service vncserver status',
      }

      

    }

    'Debian':{ # alternative for Debian
      package { 'vnc':
        ensure => 'latest',
      }
    }

  }
}

