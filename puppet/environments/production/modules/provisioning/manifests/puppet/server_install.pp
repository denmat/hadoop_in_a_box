class provisioning::puppet::server_install {
  # collect the puppet package list from hiera.
  # should be like the following
  # puppet_package_list:
  #   - puppet-server:
  #      - provider: yum
  #      - version:  latest
  #   - activerecord:
  #      - provider: gem
  #      - version: 2.0.11

  $puppet_package_list = hiera_hash('puppet_server_packages' )

  create_resources(package, $puppet_package_list)

}
