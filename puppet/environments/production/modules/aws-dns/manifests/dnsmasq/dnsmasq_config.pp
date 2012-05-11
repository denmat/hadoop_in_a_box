class aws-dns::dnsmasq_config {
  include aws-dns::dnsmasq_install
  include aws-dns::dnsmasq_service

  $dns_master_enabled = hiera('dns_master', 'absent')
  $dns_domain_list = hiera('dns_domain_list', $::domain)

  file {"/etc/dnsmasq.conf":
    ensure  => $dns_master_enabled,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => templates('aws-dns/dnsmasq.conf.erb'),
    require => Package[$aws-dns::dnsmasq_install::dnsmasq_package_list],
  }
  
}  
