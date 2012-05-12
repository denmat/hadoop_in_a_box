class aws-gluster::client_install_gluster {

  $gluster_package_list = hiera("gluster_package_list_client_$::osfamily")

  package {$gluster_package_list: ensure => latest }

}
