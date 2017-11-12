class apache{
  $distname = $::operatingsystem ? {
    'RedHat' => 'httpd',
    'Fedora' => 'httpd',	
    'Debian' => 'apache2',
  }

  package { 'apache':
    ensure => 'latest',
    name => $distname,
  }

  #file {
  
  #}
}
