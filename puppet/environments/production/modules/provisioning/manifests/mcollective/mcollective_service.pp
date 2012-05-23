class provisioning::mcollective::mcollective_service {

  include provisioning::mcollective::mcollective_server_install

  if $::operatingsystem == 'Ubuntu' {
    file {"/etc/init/mcollective.conf":
      ensure => present,
      source => "puppet:///modules/provisioning/mcollective/init.conf",
    }
  }

  $mcollective_service = hiera('mcollective_service')

  $mcollective_service_enabled = hiera('mcollective_service_enabled', 'true')

  $defaults = { 
    require => Package['mcollective'], 
    enable  => $mcollective_service_enabled,
    ensure  => $mcollective_service_enabled
  }
  create_resources(service, $mcollective_service, $defaults)

}
