class aws-pgsql::config_pgsql {

  class {"aws-pgsql::config_disks": } -> 
  class {"aws-pgsql::install_pgsql": }
}
