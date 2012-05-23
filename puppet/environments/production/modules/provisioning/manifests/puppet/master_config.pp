class provisioning::puppet::master_config {

  include provisioning::puppet::server_install

  $puppet_master = hiera('puppet_master','puppet')
  $puppet_certname = hiera('puppet_certname','puppet')
  $pgsql_password = hiera('puppet_pgsql_password')

  file {"/etc/puppet/puppet.conf":
    ensure => present,
    owner  => root,
    group  => puppet,
    mode   => 0640,
    content => template('provisioning/puppet/master_puppet.conf'),
  }

  file {"/etc/puppet/keyrings":
    ensure  => directory,
    owner   => puppet,
    mode    => 0700,
    recurse => true,
  }
}
