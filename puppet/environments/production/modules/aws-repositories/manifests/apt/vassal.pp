class aws-repositories::apt::vassal {

  include aws-repositories::apt

  file { '/etc/apt/sources.list.d/vassal.list':
    ensure  => file,
    content => 'deb http://repo.hitwise.com/apt/ oneiric vassal',
    notify  => [Exec['get_hitwise_gpg'],Exec['apt_update']]
  }

  exec {'get_hitwise_gpg':
    command     => '/usr/bin/wget http://repo.hitwise.com/apt/hitwise.asc -O - |apt-key add -',
    refreshonly => true,
  }
}

