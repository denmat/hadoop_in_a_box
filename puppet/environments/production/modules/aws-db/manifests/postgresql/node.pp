# For snoops - i know this isn't right - haven't tested - just mucking around.
class roles::aws-db {
  $postgresql_server_tablespaces = hiera('postgresql_server_tablespaces')

  include aws-db::xinetd::config
  include aws-db::iptables::service
  include aws-db::postgresql::config

  include aws-db::postgresql::commands::create_tablespace
  create_resources(aws-db::postgresql::commands::create_tablespace, $postgresql_server_tablespaces)
}
