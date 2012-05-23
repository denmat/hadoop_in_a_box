class provisioning::postgresql::config_pgsql {

  include provisioning::postgresql::install_pgsql
  $pgsql_conf_files = hiera('pgsql_config_files')

  $pgsql_file_defaults = {
    owner => postgres,
    group => postgres,
    mode  => 0600,
  }

  create_resources(file, $pgsql_conf_files, $pgsql_file_defaults)

}
