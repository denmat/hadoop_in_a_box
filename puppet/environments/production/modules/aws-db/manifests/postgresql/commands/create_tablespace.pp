# vim: ts=2:sts=2:sw=2:expandtab

define aws-db::postgresql::commands::grant_tablespace (
  $tablespace_name,
  $grant_create,
  $grant_all
  ) {
  $sql_params

  aws-db::postgresql::commands::pgsql_query_base {
    "grant_tablespace_${tablespace_name}":
      username => postgres,
      database => postgres,
      query_template => 'grant_tablespace',
      sql => {
        privilege => 'CREATE',
        role => $grant_create['name'],
        with_grant_option => $grant_create['with_grant_option']
      }
  }

    aws-db::postgresql::commands::pgsql_query_base {
    "grant_tablespace_${tablespace_name}":
      username => postgres,
      database => postgres,
      query_template => 'grant_tablespace',
      sql => {
        privilege => 'ALL',
        role => $grant_all['name'],
        with_grant_option => $grant_all['with_grant_option']
      }
  }
}

define aws-db::postgresql::commands::create_tablespace (
  $tablespace_name = $name,
  $directory
  $grant_create = undef,
  $grant_all = undef
  ) {
  include aws-db::postgresql::commands::pgsql_query_base

  aws-db::postgresql::commands::pgsql_query_base {
    "create_tablespace_${tablespace_name}":
      username => postgres,
      database => postgres,
      query_template => 'create_tablespace',
      sql => {
        tablespace_name => $tablespace_name,
        user_name => $user_name,
        directory => $directory
      }
  }

  aws-db::postgresql::commands::grant_tablespace {
    "grant_tablespace_${tablespace_name}":
      tablespace_name => $tablespace_name,
      grant_create => $grant_create,
      grant_all => $grant_all,
      require => aws-db::postgresql::commands::pgsql_query_base["create_tablespace_${tablespace_name}"]
  }
}
