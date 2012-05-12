class aws-gluster::config_gluster {
  notify {"gluster": }
#  include aws-gluster::install_gluster

  gluster {"test2":
    ensure => present,
    bricks => ['aws-east-stg-1:/test1', 'aws-east-stg-2:/test1'],
    replica => 2,
  }

}
