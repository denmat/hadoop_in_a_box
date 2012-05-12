class aws-postgresql::configuration {
  file { "/etc/sysconfig/pgsql/postgresql-9.1":
    ensure => present,
    checksum => md5,
    owner => root,
    group => root,
    mode => 0644,
    source => 'puppet:///modules/postgresql/postgresql-9.1',
    notify => Class["aws-db::postgresql::service"],
  }    

  file { "/etc/postgresql/pg_hba.conf":
    checksum => md5,
    owner => postgres,
    group => postgres,
    mode => 0640,
    notify => Class["aws-db::postgresql::service"],
    source => 'puppet:///modules/postgresql/pg_hba.conf',
  }

  file { "/etc/postgresql/postgresql.conf":
    checksum => md5,
    owner => postgres,
    group => postgres,
    mode => 0640,
    notify => Class["aws-db::postgresql::service"],
    source => 'puppet:///modules/postgresql/postgresql.conf',
  }

  file { "/etc/postgresql/pg_ident.conf":
    checksum => md5,
    owner => postgres,
    group => postgres,
    mode => 0640,
    notify => Class["aws-db::postgresql::service"],
    source => 'puppet:///modules/postgresql/pg_ident.conf',
  }
}
