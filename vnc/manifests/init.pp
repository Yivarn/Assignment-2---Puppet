class vnc{

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      package { 'tigervnc-server':
        ensure => 'latest',
      }

      file { 'setup_vnc_1':
        ensure  => 'file',
        path    => '/etc/systemd/system/vncserver@.service',
        source  => '/lib/systemd/system/vncserver@.service',
        replace => false,
        require => Package['tigervnc-server'],
      }

      exec { 'setup_vnc_2':
        cwd     => '/etc/systemd/system/',
        command => "sed -i 's/<USER>/root/' vncserver@.service",
        path    => '/bin/', # the path to sed
        require => File['setup_vnc_1'],
        unless  => '/sbin/service vncserver@:1 status',
      }

      exec { 'setup_vnc_3':
        cwd     => '/etc/systemd/system/',
        command => "sed -i 's#PIDFile=/home#PIDFile=#' vncserver@.service",
        path    => '/bin/', # the path to sed
        require => Exec['setup_vnc_2'],
        unless  => '/sbin/service vncserver@:1 status',
      }

      exec { 'setup_vnc_4':
        command => 'systemctl daemon-reload',
        path    => '/bin/', # the path to systemctl
        require => Exec['setup_vnc_3'],
        unless  => '/sbin/service vncserver@:1 status',
      }

      exec { 'setup_vnc_5':
        command => 'echo vncpasswd | vncpasswd -f > /root/.vnc/passwd',
        path    => '/bin/', # the path to vncpasswd
        require => Exec['setup_vnc_4'],
        unless  => '/sbin/service vncserver@:1 status',
      }

      exec { 'setup_vnc_6':
        command => 'systemctl enable vncserver@:1.service',
        path    => '/bin/', # the path to systemctl
        require => Exec['setup_vnc_5'],
        unless  => '/sbin/service vncserver@:1 status',
      }

      service { 'vncserver@:1':
        ensure    => 'running',
        enable    => true,
        require   => Exec['setup_vnc_6'],
        subscribe => File['setup_vnc_1'],
      }

    }

    'Debian':{ # alternative for Debian
      package { 'vnc':
        ensure => 'latest',
      }
    }

  }
}

