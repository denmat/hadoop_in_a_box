class provisioning::mcollective::rabbitmq_service {

  include provisioning::mcollective::rabbitmq_server_install

  $rabbitmq_service = hiera('rabbitmq_service_enabled', 'absent')

  service {"rabbitmq-server": 
    enable => $rabbitmq_service, 
    ensure => $rabbitmq_service,
    require => Package[$rabbitmq_package_list]
  }

}
