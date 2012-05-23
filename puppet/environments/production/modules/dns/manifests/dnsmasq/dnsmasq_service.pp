class dns::dnsmasq::dnsmasq_service {

  include dns::dnsmasq::dnsmasq_install

  $dns_service_enabled = hiera('dns_master_service', 'false')

  service {"dnsmasq": 
    enable => $dns_service_enabled,
    ensure => $dns_service_enabled,
    hasrestart => true,
    hasstatus  => true,
    require => Package[$dns::dnsmasq::dnsmasq_install::dnsmasq_package_list],
  }

}
