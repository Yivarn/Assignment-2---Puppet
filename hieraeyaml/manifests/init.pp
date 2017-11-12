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
    cwd => '/etc/puppetlabs/puppet/',
    command => 'eyaml createkeys',
    path => ['/opt/puppetlabs/puppet/bin/','/bin/'],
    creates => ['/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem',
                '/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem'],
  }

  file { '/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem':
    ensure => 'file',
    mode => '0400',
    require => Exec['createkeys'],
  }

  file { '/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem':
    ensure => 'file',
    mode => '0400',
    require => Exec['createkeys'],
  }

  file { '/etc/puppetlabs/puppet/keys/':
    ensure => 'directory',
    mode => '0500',
    require => Exec['createkeys'],
  }
}
