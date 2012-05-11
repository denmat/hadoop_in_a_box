# vim: ts=2:sts=2:sw=2:expandtab

define sqlexec($username, $password, $database, $sql, $sqlcheck, $mode="unixsock") {
  if $mode == "unixsock" {
    $hostname = ""
  } else {
    $hostname = "-h localhost"
  }

  exec {
    "psql ${hostname} -U ${username} $database -c \"${sql}\"":
      environment => "PGPASSWORD=\"$password\""
      path => $path,
      timeout => 600,
      unless => "PGPASSWORD=\"${password}\" psql ${hostname} -U ${username} $database -c \"${sql}\"",
      require => Service[postgresql]
  }
}
