define aws-gluster::mount_gluster($ensure = absent, $stg_device, $options = undef) {

  $mount_point = $name

  $dir_mount = hiera('gluster_mount_point')

  create_resources(file, $dir_mount)

  mount {$name:
    ensure => $ensure,
    device => $stg_device,
    fstype => glusterfs,
    options => "nobarrier,noatime,noadirtime,defaults,$options",
    require => File[$mount_point],
  }

}
