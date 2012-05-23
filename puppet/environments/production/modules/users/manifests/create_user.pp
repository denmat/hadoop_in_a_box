define users::create_user ($user, $groups = undef ) {
  include users

  if ($groups) {
    $users = hiera_hash("$user")
    $user_groups = hiera_hash("$groups")
#    $user_defaults = hiera_hash("user_defaults")
    create_resources(user, $users, $user_groups)
  } else {
    $users = hiera_hash("$user")
    create_resources(user, $users)
  }
}   
