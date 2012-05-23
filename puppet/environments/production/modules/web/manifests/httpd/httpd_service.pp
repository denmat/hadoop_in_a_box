class web::httpd::httpd_service {

  $httpd_service = hiera('httpd_service')

  create_resources(service, $httpd_service)

}
