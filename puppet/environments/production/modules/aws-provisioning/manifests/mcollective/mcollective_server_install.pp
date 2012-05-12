class aws-provisioning::mcollective::mcollective_server_install {

  class {"aws-provisioning": stage => repos }

  $mcollective_package_list = hiera('mcollective_server_packages' )

  create_resources(package, $mcollective_package_list)

}
