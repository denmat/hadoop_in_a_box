class repositories::apt {

  exec {"apt_update":
    command     => '/usr/bin/aptitude update',
    refreshonly => true,
  }
}
