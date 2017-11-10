class puppetconf {
  
  augeas { 'puppetruninterval':
    context => "/files/etc/puppetlabs/puppet/puppet.conf/agent", # path to file
    changes => 'set runinterval 1190', # set ~19.8 minutes between runs
  }
}
