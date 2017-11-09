class hieraeyaml {

  exec { 'gem install hiera-eyaml':
    path => ['/opt/puppetlabs/puppet/bin','/bin'],
    creates => '/opt/puppetlabs/puppet/bin/eyaml',
  }

  exec { 'puppetserver gem install hiera-eyaml':
    path => ['/opt/puppetlabs/bin','/bin','/sbin'],
    creates => '/opt/puppetlabs/server/data/puppetserver/jruby-gems/bin/eyaml',
  }

  exec { 'createkeys':
    command => 'eyaml createkeys',
    path => ['/opt/puppetlabs/puppet/bin/','/bin/'],
    creates => '/opt/puppetlabs/puppet/bin/keys/private_key.pkcs7.pem',
  }


}
