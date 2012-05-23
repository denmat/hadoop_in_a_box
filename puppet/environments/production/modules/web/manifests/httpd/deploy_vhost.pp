define web::httpd::deploy_vhost {

  include web::httpd::httpd_install
  include web::httpd::httpd_config
  include web::httpd::httpd_service

  $vhostname = $name

  $defaults = { require => Package['httpd'], notify => Service['httpd'] }

  $httpd_vhost_files = hiera("deploy_vhost_$vhostname")


  create_resources(file, $httpd_vhost_files, $defaults)
  
}
