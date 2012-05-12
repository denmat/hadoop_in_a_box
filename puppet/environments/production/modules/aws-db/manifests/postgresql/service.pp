# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::postgresql::service {
  include aws-db::postgresql::initdb

  $postgresql_server_version = hiera('postgresql_server_version')
  $postgresql_service_enabled = hiera('postgresql_service_enabled', 'true')

  service {
    "postgresql-${postgresql_server_version}":
      ensure     => $postgresql_service_enabled,
      enable     => $postgresql_service_enabled,
      hasstatus  => true,
      hasrestart => true,
      name => "postgresql-${postgresql_server_version}",
      require => [Exec['aws_db_postgresql_initdb_exec'],File['aws_db_postgresql_initdb_managed']]
  }
}
