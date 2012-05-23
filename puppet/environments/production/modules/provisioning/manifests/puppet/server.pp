class provisioner::puppet::server {

  include "provisioning::puppet::server_install"

  $puppet_master = hiera('puppet_master','puppet')
  $puppet_certname = hiera('puppet_certname','puppet')

  file {"/etc/puppet/puppet.conf":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    content => template('server/puppet_server.conf'),
  }

}
