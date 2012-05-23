class dns::dnsmasq::dnsmasq_install {

  $dnsmasq_package_list = ['dnsmasq']
  $dns_master = hiera('dns_master', 'purged')

  package {$dnsmasq_package_list: ensure => $dns_master }

}
