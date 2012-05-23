class provisioning::puppet::puppet_testing {

  include provisioning::puppet

  $testing_packages = hiera('puppet_testing_packages')

  create_resources(package, $testing_packages)

  exec { 'testing_copy':
    command => "/usr/bin/rsync -a /var/lib/puppet/yaml/node/ /etc/puppet/features/yaml/",
    require => File['puppet_cucumber_tests'],
  }

  file { 'puppet_cucumber_tests':
    path    => '/etc/puppet/features',
    ensure  => directory,
    owner   => puppet,
    group   => wheel,
    source  => "puppet:///modules/provisioning/puppet/testing/features",
    recurse => true,
    ignore  => 'features/yaml',
  }
}
