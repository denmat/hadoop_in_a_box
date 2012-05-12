class aws-gluster::install_gluster {

    $gluster_package_list = hiera('gluster_package_list_server')

  package {$gluster_package_list: ensure => latest }

}
