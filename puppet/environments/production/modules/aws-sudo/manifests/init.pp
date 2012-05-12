class aws-sudo {

  File { ensure => present, owner => root, group => root, mode => 0440 }

  file {$::aws_role:
    path   => "/etc/sudoers.d/$::aws_role",
    source => "puppet:///modules/aws-sudo/$::aws_role",
  }
}
