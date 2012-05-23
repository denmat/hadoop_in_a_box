class provisioning::postgresql::initdb {

  require provisioning::postgresql::install_pgsql

  $postgresql_server_base = hiera('postgresql_server_base')
  $postgresql_server_data = hiera('postgresql_server_data')
  $postgresql_encoding = hiera('postgresql_encoding')
  $postgresql_locale = hiera('postgresql_locale')

  exec {
    'InitDB':
      command => "/usr/bin/initdb -D ${postgresql_server_data} -E ${postgresql_encoding} --locale=${postgresql_locale}",
      user => postgres,
      creates => "${postgresql_server_data}/PG_VERSION",
      require => Package['postgresql-server']
  }
}
