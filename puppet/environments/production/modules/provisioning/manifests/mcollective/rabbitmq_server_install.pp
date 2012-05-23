class provisioning::mcollective::rabbitmq_server_install {

  $rabbitmq_package_list = hiera('rabbitmq_package_list')

  create_resources (package, $rabbitmq_package_list )

}
