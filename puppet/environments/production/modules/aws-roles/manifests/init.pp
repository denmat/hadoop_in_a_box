# Class: roles
#
# This module manages roles
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
class aws-roles {

  # add hosts to dns and issue restart of dnsmasq
  include aws-dns
    aws-dns::add_node { "$::fqdn": }

  # add admin users to all hosts.
  include aws-users
  if ($::osfamily == 'Debian') {
    aws-users::create_user {"admin_users": user => 'admin_users', groups => 'admin_groups_ubuntu', require => File['/etc/skel/.ssh'] }
  } else {
    aws-users::create_user {"admin_users": user => 'admin_users', groups => 'admin_groups_ec2', require => File['/etc/skel/.ssh'] }
  }

  $admin_public_keys = hiera('admin_public_keys')
  $public_key_defaults = hiera('public_key_defaults')

  create_resources (ssh_authorized_key, $admin_public_keys, $public_key_defaults)

  # adding sudoers based on roles.
  include aws-sudo
  # add mcollective for all servers
  include aws-provisioning::mcollective::mcollective_server_config

  if $::aws_role == 'webserver' {
    include aws-roles::aws_webservices
  }
  if $::aws_role =~ /^db\w+$/ {
    include aws-roles::aws_dbservices
  }
  if $::aws_role == 'stgserver' {
    include aws-roles::aws_stg
  }
  if $::aws_role == 'provisioner' {
    include aws-roles::aws_provisioner
  }
  if $::aws_role == 'bastion' {
    include aws-roles::aws_bastion
  }
}
