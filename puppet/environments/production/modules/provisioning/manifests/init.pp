# Class: provisioning
#
# This module manages provisioning
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
class provisioning {

  if $::osfamily == 'RedHat' or $::osfamily == 'Linux' {
    $yum_repositories = hiera('yum_repos')

    create_resources(yumrepo, $yum_repositories)
  }

  package { 'mercurial':
    ensure => latest
  }

}
