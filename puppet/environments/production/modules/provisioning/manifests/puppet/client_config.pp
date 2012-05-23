class provisioning::puppet::client_config {

  include "provisioning::puppet::client_install"

  $puppet_master = hiera('puppet_master','puppet')

  file {"/etc/puppet/puppet.conf":
    ensure => present,
    owner  => root,
    group  => puppet,
    mode   => 0640,
    content => template('client/client_puppet.conf'),
  }

}
