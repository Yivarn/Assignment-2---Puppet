class sshfs {

  case $::operatingsystem { # switch depending on OS

    'RedHat': { # if the operating system is RedHat

      exec { 'getlib64fuse': # dependency required for fuse-sshfs
        cwd     => '/var/tmp', # the directory to download into 
        command => 'wget ftp://195.220.108.108/linux/mageia/distrib/cauldron/x86_64/media/core/release/lib64fuse2-2.9.7-3.mga7.x86_64.rpm', # the download command and url
        onlyif  => 'test ! -f /bin/sshfs', # do not download if sshfs is present already - no need
        path    => '/usr/bin', # the path to wget
      }

       package { 'lib64fuse2.x86_64':
  ensure   => 'present',
        provider => 'rpm',
        source   => '/var/tmp/lib64fuse2-2.9.7-3.mga7.x86_64.rpm',
        require  => Exec['getlib64fuse'], # Ensure the package is downloaded first
      }

      exec { 'getsshfs':
        cwd     => '/var/tmp', # the directory to download into 
        command => 'wget ftp://195.220.108.108/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/f/fuse-sshfs-2.8-4.fc27.x86_64.rpm', # the download command and url
        onlyif  => 'test ! -f /bin/sshfs', # do not download if sshfs is present already - no need
        path    => '/usr/bin', # the path to wget
      }

      package { 'sshfs':
  ensure   => 'present',
        provider => 'rpm',
        source   => '/var/tmp/fuse-sshfs-2.8-4.fc27.x86_64.rpm',
        require  => [ Exec['getsshfs'], Package['lib64fuse2.x86_64']], # Ensure the package is downloaded first and dependency installed.
      }
    }

    'Debian':{ # alternative for Debian
      package { 'sshfs':
        ensure => 'latest',
      }
    }

  }
}
