class provisioning::puppet::client {

  include "provisioning::puppet::client_install"

  $puppet_master = hiera('puppet_master','puppet')

  file {"/etc/puppet/puppet.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    content => template('client/puppet_client.conf'),
  }

}
