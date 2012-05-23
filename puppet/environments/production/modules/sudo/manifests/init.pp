class sudo {

  File { ensure => present, owner => root, group => root, mode => 0440 }

  file {$::role:
    path   => "/etc/sudoers.d/$::role",
    source => "puppet:///modules/sudo/$::role",
  }
}
