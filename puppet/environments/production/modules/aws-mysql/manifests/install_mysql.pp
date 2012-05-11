class aws-mysql::install_mysql {

   $mysql_package_list = hiera('mysql_package_list')

   create_resources (package, $mysql_package_list)

}
