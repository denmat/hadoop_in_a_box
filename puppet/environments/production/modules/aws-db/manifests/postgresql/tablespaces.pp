# vim: ts=2:sts=2:sw=2:expandtab

define aws-db::postgresql::tablespace(
  $username,
  $password,
  $database,
  $sql,
  $sqlcheck,
  $mode,
  $name,
  $location 
) {
  file {
    $location:
      ensure => directory,
      owner => postgres,
      group => postgres,
      recurse => true,
      mode => 0700
  }

  file {
    "$location/lost+found":
      recurse => true,
      ensure => absent
  }

  exec {
  ::sqlexec($username, $password, $database, $sql, $sqlcheck, $name, $location)
}
