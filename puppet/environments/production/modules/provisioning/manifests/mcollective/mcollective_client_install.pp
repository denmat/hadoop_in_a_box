class provisioning::mcollective::mcollective_client_install {

  $mcollective_package_list = hiera('mcollective_client_packages', 'test1')

  create_resources(package, $mcollective_package_list)

}
