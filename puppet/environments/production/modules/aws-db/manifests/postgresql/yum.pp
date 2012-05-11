# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::postgresql::yum {
  $postgresql_server_version = hiera('postgresql_server_version')

  case $postgresql_server_version {
    /^9.1/: {
      exec {
        'aws_db_postgresql_yum':
          command => "/bin/rpm -Uvh http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/pgdg-redhat91-9.1-5.noarch.rpm"
          creates => ['/etc/yum.repos.d/pgdg-91-redhat.repo', '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-91'],
      },
    },
    default: {
      fail "No PostgreSQL server version number was found."
    },
  },
}
