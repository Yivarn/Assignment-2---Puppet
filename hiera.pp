class { 'hiera':
  hierarchy => [
    'secure',
    '%{fqdn}',
    '%{environment}',
    'common'
  ],
  eyaml => true,
}
