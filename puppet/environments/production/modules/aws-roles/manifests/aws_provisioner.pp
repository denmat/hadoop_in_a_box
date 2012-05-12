class aws-roles::aws_provisioner {

  include aws-provisioning::mcollective::mcollective_server_config
  include aws-provisioning::mcollective::mcollective_client_config
  include aws-provisioning::postgresql
  class {"aws-provisioning::postgresql::initdb": } ->
  class {"aws-provisioning::postgresql::config_pgsql": } ->
  aws-provisioning::postgresql::pgsql_create_db {"puppet": } ->
  class {"aws-provisioning::puppet::master_config": }

}
