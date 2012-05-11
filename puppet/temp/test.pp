class test {
  $that = hiera('yum_repos')
  notify{$that: }
}

include test
