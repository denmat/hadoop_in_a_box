define provisioning::postgresql::pgsql_create_db {

  $new_db = $name
  $db_pw = hiera("${new_db}_db_password")
  $db_user = hiera("${new_db}_db_user")

  exec {"create_db":
    command => "/usr/bin/createdb $new_db",
    onlyif  => "/usr/bin/test `psql -l |grep  -c $new_db` -eq 0",
    user    => 'postgres',
    require => Class['provisioning::postgresql::install_pgsql'],
    notify  => Exec['set_password']
  }

  exec {"set_password":
    command     => "/usr/bin/psql -c \"create role $db_user with nosuperuser createdb LOGIN PASSWORD 'md5$db_pw';\" ",
    onlyif      => "/usr/bin/test `psql puppet -c \"\du\" |grep -c $db_user` -eq 0",
    refreshonly => true,
    user        => 'postgres',
    require     => Exec['create_db'],
  }

}
