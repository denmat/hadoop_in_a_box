class aws-provisioning::mcollective::mcollective_server_config {

  include aws-provisioning::mcollective::mcollective_server_install
  include aws-provisioning::mcollective::mcollective_service

  $mcollective_client_password = hiera('mcollective_client_password')
  $stompd_client_password = hiera('stompd_client_password')
  $stompd_host = hiera('stompd_host')

  file {"/etc/mcollective/server.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    content => template('aws-provisioning/mcollective/server.cfg.erb'),
    require => Package["mcollective"],
    notify  => Service['mcollective'],
  }

  if $::osfamily == 'Debian' {
    $plugin_dir = "/usr/share/mcollective/plugins"
  } else {
    $plugin_dir = "/usr/libexec/mcollective"
  }

  file { "$plugin_dir/mcollective":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0764,
    source  => "puppet:///modules/aws-provisioning/mcollective/plugins",
    recurse => true,
    purge   => true,
    force   => true,
    require => Package["mcollective"],
    notify  => Service['mcollective'],
  }
}
