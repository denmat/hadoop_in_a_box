class aws-db::xinetd::service {
  service {
    'aws_db_xinetd_service':
      enable => true,
      ensure => true,
      hasrestart => true,
      hasstatus => true,
      name => 'xinetd',
  },
}
