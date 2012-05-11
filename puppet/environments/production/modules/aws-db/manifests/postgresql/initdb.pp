# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::postgresql::initdb {
  include aws-db::postgresql::install 

  $postgresql_server_base = hiera('postgresql_server_base')
  $postgresql_server_version = hiera('postgresql_server_version')
  $postgresql_server_system = hiera('postgresql_server_system')
  $postgresql_server_xlog = hiera('postgresql_server_xlog')
  $postgresql_server_locale = hiera('postgresql_server_locale')
  $postgresql_server_encoding = hiera('postgresql_server_encoding')
  $postgresql_server_managed = hiera('postgresql_server_managed')

  file {
    'aws_db_postgresql_initdb_system_dirs':
      path => [ $postgresql_server_base, $postgresql_server_system, $postgresql_server_xlog ]:
      ensure => directory,
      owner => postgres,
      group => postgres,
      recurse => true,
      mode => 0700,
      require => Package['postgresql_installed_package'] 
  }

  file {
    'aws_db_postgresql_initdb_ext_clean':
      path => [ "$postgresql_server_system/lost+found", "$postgresql_server_xlog/lost+found" ]:
      recurse => true,
      ensure => absent,
      require => File['aws_db_postgresql_initdb_system_dirs']
  }

  exec {
    'aws_db_postgresql_initdb_exec':
      command => "/usr/pgsql-${postgresql_server_version}/bin/initdb -D $postgresql_server_system -E $postgresql_server_encoding --locale=$postgresql_server_locale --xlogdir=$postgresql_server_xlog",
      user => postgres,
      creates => "/srv/pgsql/${postgresql_server_version}/system/PG_VERSION",
      require => [Package['postgresql_installed_package'],File['aws_db_postgresql_initdb_system_dirs'],File['aws_db_postgresql_initdb_ext_clean']]
  }

  if $postgresql_server_managed {
    file {
      'aws_db_postgresql_initdb_managed':
        path => ["$postgresql_server_system/postgresql.conf", "$postgresql_server_system/pg_ident.conf", "$postgresql_server_system/pg_hba.conf"]:
        ensure => absent,
        require => Exec['aws_db_postgresql_initdb_exec']
    }
  }
}
