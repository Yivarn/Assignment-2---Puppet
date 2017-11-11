class users{

    exec { 'bashrc':
      cwd => '/etc/skel/',
      command => 'echo "export PATH=${PATH}:/usr/local/bin" >> .bashrc',
      path => '/bin/',
      unless => '/bin/cat /etc/skel/.bashrc | /bin/grep ":/usr/local/bin"',
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
        name => 'becca',
        ensure => present,
        home => '/home/becca',
        groups => ['sysadmin', 'cars'],
        managehome => true,
        uid => 10017699,
#        password => 'hiera',
        shell => '/bin/bash',
        require => Exec['bashrc'],
    }
    user { 'fred':
        name => 'fred',
        ensure => present,
        home => '/home/fred',
        groups => ['cars', 'trucks'],
        managehome => true,
        uid => 10027699,
#        password => 'hiera',
        shell => '/bin/csh',
        require => Exec['bashrc'],
    }
    user { 'wilma':
        name => 'wilma',
        ensure => present,
        home => '/home/wilma',
        groups => ['cars', 'trucks', 'ambulances'],
        managehome => true,
        uid => 10037699,
#        password => hiera('profile::user::users:wilma:password:'),
        shell => '/bin/csh',
        require => Exec['bashrc'],
    }

    ssh_authorized_key { 'wilma_ssh_key':
      ensure => present,
      user   => 'wilma',
      type   => 'ssh-rsa',
      key    => 'Hiera',
      require => User['wilma'],
    }

    augeas { 'disable_root_ssh_logins':
      context => "/files/etc/ssh/sshd_config",
      changes => 'set PermitRootLogin no',
    }

    file { '/home/becca/titan/':
      ensure => 'directory',
      require => User['becca'],
    }

    mount { 'titan_sshfs':
      name => '/home/becca/titan/',
      ensure => 'mounted',
      fstype => 'fuse.sshfs',
      device => 's3627699@131.170.5.131:/',
      options => 'defaults',
      atboot => true,
      remounts => true,
      require => File['/home/becca/titan/'], 
    }

}

