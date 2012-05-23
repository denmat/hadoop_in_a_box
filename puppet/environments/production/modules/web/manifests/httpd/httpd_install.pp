class web::httpd::httpd_install {

  $httpd_package_list = hiera('httpd_package_list')

  create_resources(package, $httpd_package_list)

}
