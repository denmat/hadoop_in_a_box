class web::httpd::httpd_config {

   
   $httpd_conf = hiera('httpd_conf')
   $httpd_defaults = { owner => root, group => root, mode => 0644, require => Package['httpd'], notify => Service['httpd'] }

   create_resources(file, $httpd_conf, $httpd_defaults)

}
