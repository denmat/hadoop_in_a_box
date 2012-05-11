class aws-provisioning::mcollective::mcollective_service {

  include aws-provisioning::mcollective::mcollective_server_install

  $mcollective_service = hiera('mcollective_service_enabled', 'true')

  service {"mcollective": 
    enable => $mcollective_service, 
    ensure => $mcollective_service, 
    require => Package['mcollective'] 
  }

}
