class users{

    exec { 'bashrc':
      cwd     => '/etc/skel/',
      command => 'echo "export PATH=${PATH}:/usr/local/bin" >> .bashrc',
      path    => '/bin/',
      unless  => '/bin/cat /etc/skel/.bashrc | /bin/grep ":/usr/local/bin"',
    }

    # Group Config:
    group{ 'cars':
        ensure => present
    }
    group{ 'trucks':
        ensure => present
    }
    group{ 'ambulances':
        ensure => present
    }
    group{ 'sysadmin':
        ensure => present
    }

    # User Config:
    user { 'becca':
        ensure     => present,
        name       => 'becca',
        home       => '/home/becca',
        groups     => ['sysadmin', 'cars'],
        managehome => true,
        uid        => 10017699,
#        password => lookup('beccapass'),
        shell      => '/bin/bash',
        require    => Exec['bashrc'],
    }
    user { 'fred':
        ensure     => present,
        name       => 'fred',
        home       => '/home/fred',
        groups     => ['cars', 'trucks'],
        managehome => true,
        uid        => 10027699,
#        password => lookup('fredpass'),
        shell      => '/bin/csh',
        require    => Exec['bashrc'],
    }
    user { 'wilma':
        ensure     => present,
        name       => 'wilma',
        home       => '/home/wilma',
        groups     => ['cars', 'trucks', 'ambulances'],
        managehome => true,
        uid        => 10037699,
#        password => lookup('wilmapass'),
        shell      => '/bin/csh',
        require    => Exec['bashrc'],
    }

    ssh_authorized_key { 'wilma_ssh_key':
      ensure  => present,
      user    => 'wilma',
      type    => 'ssh-rsa',
      key     => 'test',
#      key    => lookup('wilmassh'),
      require => User['wilma'],
    }

    augeas { 'disable_root_ssh_logins':
      context => '/files/etc/ssh/sshd_config',
      changes => 'set PermitRootLogin no',
    }

    file { '/home/becca/titan/':
      ensure  => 'directory',
      require => User['becca'],
    }

    mount { 'titan_sshfs':
#      ensure   => 'mounted',
      name     => '/home/becca/titan/',
      fstype   => 'fuse.sshfs',
      device   => 's3627699@131.170.5.131:/',
      options  => 'defaults',
      atboot   => true,
      remounts => true,
      require  => File['/home/becca/titan/'],
    }

}

