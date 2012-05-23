define users::ssh_keys($user = undef) {

  if ($user) {
    @generate("/usr/bin/ssh-keygen -b 4096 -f /home/$user/.ssh/id_rsa")
  }
}
