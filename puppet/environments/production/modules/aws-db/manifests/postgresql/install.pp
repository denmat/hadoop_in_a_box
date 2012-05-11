# vim: ts=2:sts=2:sw=2:expandtab

class aws-db::postgresql::install {
  include aws-db::postgresql::yum
  
  $postgresql_server_package_conflicts = hiera('postgresql_server_package_conflicts')
  $postgresql_server_packages = hiera('postgresql_server_packages')

  create_resources(package, $postgresql_server_package_conflicts)
  create_resources(package, $postgresql_server_packages)
}
