class aws-pgsql::service {

  $service_enabled = hiera('pgsql_service', 'true')
  service {'postgresql': 
    ensure     => $service_enabled,
    enable     => $service_enabled,
    hasstatus  => true,
    hasrestart => true,
  }
}
