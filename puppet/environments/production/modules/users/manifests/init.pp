class users {
  file {"/etc/skel":
    ensure  => directory,
    source  => "puppet:///modules/users/common/skel",
    recurse => true,
  } ->
  file {"/etc/skel/.ssh":
    mode    => 0700,
    require => File['/etc/skel'],
  } 
}
