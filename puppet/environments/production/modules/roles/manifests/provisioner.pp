class roles::provisioner {


  include provisioning::mcollective::mcollective_server_config
  include provisioning::postgresql
  class {"provisioning::postgresql::initdb": } ->
  class {"provisioning::postgresql::config_pgsql": } ->
  provisioning::postgresql::pgsql_create_db {"puppet": } ->
  class {"provisioning::puppet::master_config": }

  include web::httpd
  web::httpd::deploy_vhost {"puppetmaster": }

  include provisioning::puppet::puppet_testing

}
