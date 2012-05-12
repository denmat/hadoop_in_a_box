# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::postgresql::config {
  include aws-db::postgresql::initdb
  
  $postgresql_server_version = hiera('postgresql_server_version')
  $postgresql_server_managed_files = hiera('postgresql_server_managed_files')

  $defaults = {
    ensure => present,
    checksum => md5,
    owner => postgres,
    group => postgres,
    mode => 0640,
    require => Service["postgresql-${postgresql_server_version}"],
    notify => Service["postgresql-${postgresql_server_version}"]
  }

  create_resources(file, $postgresql_server_managed_files, $defaults)
}
