# vim: ts=2:sts=2:sw=2:expandtab

define aws-db::postgresql::commands::pgsql_query(
  $username,
  $password,
  $database,
  $sql,
  $mode       = 'unixsock'
  ) {
  include aws-db::postgresql::commands::pgsql_query_base

  aws-db::postgresql::commands::pgsql_query_base {
    "pgsql_query_${name}":
      username => $username,
      password => $password,
      database => $database,
      query_template => 'generic_query',
      sql => $sql,
      mode => $mode
  }
}

