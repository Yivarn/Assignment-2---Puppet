class hieraeyaml { 
  exec { 'install hiera-eyaml': 
    command => "puppetserver gem install hiera-eyaml",
    unless => "puppetserver gem list --local | grep hiera-eyaml",
    path => ['/usr/bin', '/opt/puppetlabs/bin'],
  }
}
