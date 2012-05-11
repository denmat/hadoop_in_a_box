# vim: ts=2:sts=2:sw=2:expandtab

define aws-db::postgresql::commands::pgsql_query_base(
  $username = 'postgres',
  $password = 'postgres',
  $database = 'postgres',
  $query_template,
  $sql,
  $mode       = 'unixsock'
  ) {
  include aws-db::postgresql::service

  $postgresql_server_version = hiera('postgresql_server_version')

  if $mode == 'unixsock' {
    $hostname = ''
  } else {
    $hostname = '-h localhost'
  }

  $query_path = "/var/lib/pgsql/.pgsqlquery_${name}.sql"

  file {
    "pgsqlquery-${name}.sql":
      ensure => present,
      mode => 0600,
      owner => postgres,
      group => postgres,
      path => $query_path
      content => template("aws-db/${query_template}.erb")
      notify => Exec["pgsqlquery-${name}"],
      require => Service["postgresql-${postgresql_server_version}"]
  }

  exec {
    "psqlquery-${name}":
      command => "psql ${hostname} -U $username $database -f $query_path",
      environment => ["PGPASSWORD=\"$password\"","ON_ERROR_STOP=1"],
      timeout => 300,
      refreshonly => true,
      subscribe => File["pgsqlquery-${name}.sql"]
      path => [ '/usr/bin' , '/usr/sbin' ],
  }
}
