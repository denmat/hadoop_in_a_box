class provisioning::postgresql::install_pgsql {

   $pgsql_package_list = hiera('pgsql_package_list')

   create_resources (package, $pgsql_package_list)

}
