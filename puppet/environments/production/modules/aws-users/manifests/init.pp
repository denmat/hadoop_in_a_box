# Class: aws-users
#
# This module manages aws-users
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class aws-users {
  file {"/etc/skel":
    ensure  => directory,
    source  => "puppet:///modules/aws-users/common/skel",
    recurse => true,
  } ->
  file {"/etc/skel/.ssh":
    mode    => 0700,
    require => File['/etc/skel'],
  } 
}
