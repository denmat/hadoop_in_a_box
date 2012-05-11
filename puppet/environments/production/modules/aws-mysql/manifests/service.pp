class aws-mysql::service {

  $service_enabled = hiera('mysql_service', 'true')
  service {'mysqld': 
    ensure     => $service_enabled,
    enable     => $service_enabled,
    hasstatus  => true,
    hasrestart => true,
  }
}
