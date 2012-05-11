class aws-mysql::config_mysql {

  class {"aws-mysql::config_disks": } -> 
  class {"aws-mysql::install_mysql": }
}
