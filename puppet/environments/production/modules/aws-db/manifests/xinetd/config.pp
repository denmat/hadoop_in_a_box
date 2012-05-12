# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::xinetd::config {
  include aws-db::xinetd::service

  file {
    '/etc/services':
      ensure => present,
      owner => root,
      group => root,
      mode => 0644,
      source => 'puppet://modules/aws-db/xinetd/services',
      notify => Service['aws_db_xinetd_service'],
  }
}
