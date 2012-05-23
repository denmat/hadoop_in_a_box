class web::nginx::nginx_install {
  
  $nginx_package_list = hiera('nginx_package_list','nginx')

  create_resources(package, $nginx_package_list)

}
