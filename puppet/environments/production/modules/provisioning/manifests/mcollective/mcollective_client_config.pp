class provisioning::mcollective::mcollective_client_config {

  include provisioning::mcollective::mcollective_client_install 

  $mcollective_client_password = hiera('mcollective_client_password')
  $stompd_client_password = hiera('stompd_client_password')
  $stompd_host = hiera('stompd_host')

  file {"/etc/mcollective/client.cfg":
    ensure  => present,
    owner   => root,
    group   => root,
    content => template('provisioning/mcollective/client.cfg.erb'),
    require => Package["mcollective-client"],
#    notify  => Service['mcollective'],
  }

}
