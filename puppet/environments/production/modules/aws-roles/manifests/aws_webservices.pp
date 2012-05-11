class aws-roles::aws_webservices {

  class {"aws-repositories::apt::puppetlabs": stage => repos }

  include aws-provisioning::mcollective::mcollective_client_config

}
