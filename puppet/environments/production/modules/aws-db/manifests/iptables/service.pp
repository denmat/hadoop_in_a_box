class aws-db::iptables::service {
  service {
    'iptables':
      enable => false,
      ensure => stopped,
  },
}
