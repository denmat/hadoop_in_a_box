class aws-provisioning::puppet::client_install {

  $puppet_client_list = hiera("puppet_client_packages_$osfamily", 'puppet')

  create_resources(package, $puppet_client_list)

}
