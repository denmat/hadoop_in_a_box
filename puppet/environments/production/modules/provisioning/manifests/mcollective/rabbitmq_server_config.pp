class provisioning::mcollective::rabbitmq_server_config {

  include provisioning::mcollective::rabbitmq_server_install

  file {"/etc/rabbitmq/rabbitmq.config":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    source => "puppet:///modules/stomp/rabbitmq.config",
  }
}
