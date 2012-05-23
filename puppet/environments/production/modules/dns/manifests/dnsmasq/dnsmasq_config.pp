class dns::dnsmasq_config {
  include dns::dnsmasq_install
  include dns::dnsmasq_service

  $dns_master_enabled = hiera('dns_master', 'absent')
  $dns_domain_list = hiera('dns_domain_list', $::domain)

  file {"/etc/dnsmasq.conf":
    ensure  => $dns_master_enabled,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => templates('dns/dnsmasq.conf.erb'),
    require => Package[$dns::dnsmasq_install::dnsmasq_package_list],
  }
  
}  
