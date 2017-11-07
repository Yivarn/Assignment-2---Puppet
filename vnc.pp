class vnc{
  $distname = $::operatingsystem ? {
    'RedHat' => 'tigervnc-server',
    'Debian' => 'vnc-server',
  }

  package { 'vnc':
    ensure => 'latest',
    name => $distname,
  }
}
