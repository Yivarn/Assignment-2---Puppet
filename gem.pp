class gem { 
  exec { 'puppetlabs-puppetserver_gem': 
    command => "puppet module install puppetlabs-puppetserver_gem",
    unless => "puppet module list | grep puppetlabs-puppetserver_gem",
    path => ['/usr/bin', '/opt/puppetlabs/bin'],
  }
}
