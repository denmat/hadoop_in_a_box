define dns::add_node {

  # add the ip address of eth0 to /etc/hosts and restart dnsmasq
  @@host {$name:
    ip   => $::ipaddress,
    host_aliases => ["$::node.$::domain",$::node ],
  }

  if $::puppet == 'master' {
    include dns::dnsmasq::dnsmasq_service

    Host <<| |>> ->
    exec {"/bin/true":
      notify => Service['dnsmasq']
    }
  }
}

  
