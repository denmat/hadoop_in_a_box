class web::nginx::nginx_config {
  include web::nginx::nginx_install

  $nginx_conf_defaults = { 'require' => 'Package["nginx"]', 'notify' => 'Service["nginx"]' }
  $nginx_conf_files = hiera('nginx_conf_files')

  create_resources(file, $nginx_conf_files, $nginx_conf_defaults)

}
