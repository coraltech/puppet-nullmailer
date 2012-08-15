
class nullmailer::default {

  $package_ensure = 'present'
  $service_ensure = 'running'
  $remotes        = []

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $package          = 'nullmailer'
      $service          = 'nullmailer'

      $config_dir       = '/etc/nullmailer'
      $remotes_dir      = "${config_dir}/remotes"

      $remotes_template = 'nullmailer/remotes.erb'
    }
    default: {
      fail("The nullmailer module is not currently supported on ${::operatingsystem}")
    }
  }
}
