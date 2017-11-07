class hierainstall {
  exec { 'puppet-hiera':
    command => "puppet module install puppet-hiera",
    unless => "puppet module list | grep puppet-hiera",
    path => ['/usr/bin', '/opt/puppetlabs/bin'],
  }
}
