class repositories::apt::puppetlabs {

  include repositories::apt

  file { '/etc/apt/sources.list.d/puppetlabs.list':
    ensure  => file,
    content => 'deb http://apt.puppetlabs.com/ubuntu oneiric main',
    notify  => [Exec['get_puppet_gpg'],Exec['apt_update']]
  }

  exec {'get_puppet_gpg':
    command     => '/usr/bin/wget http://apt.puppetlabs.com/pubkey.gpg -O - |apt-key add -',
    refreshonly => true,
  }
}

