define aws-dns::add_node {

  # add the ip address of eth0 to /etc/hosts and restart dnsmasq
  @@host {$name:
    ip   => $::ipaddress,
    host_aliases => ["$::aws_node.$::domain",$::aws_node ],
  }

  if $::aws_puppet == 'master' {
    include aws-dns::dnsmasq::dnsmasq_service

    Host <<| |>> ->
    exec {"/bin/true":
      notify => Service['dnsmasq']
    }
  }
}

  
