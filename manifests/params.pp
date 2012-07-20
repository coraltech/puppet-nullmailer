
class nullmailer::params {

  include nullmailer::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $nullmailer_package_ensure = hiera('nullmailer_package_ensure', $nullmailer::default::nullmailer_package_ensure)
    $nullmailer_service_ensure = hiera('nullmailer_service_ensure', $nullmailer::default::nullmailer_service_ensure)
    $remotes                   = hiera('nullmailer_remotes', $nullmailer::default::remotes)
  }
  else {
    $nullmailer_package_ensure = $nullmailer::default::nullmailer_package_ensure
    $nullmailer_service_ensure = $nullmailer::default::nullmailer_service_ensure
    $remotes                   = $nullmailer::default::remotes
  }

  #-----------------------------------------------------------------------------
  # Operating system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_nullmailer_package = 'nullmailer'
      $os_nullmailer_service = 'nullmailer'

      $os_config_dir         = '/etc/nullmailer'
      $os_remotes_dir        = "${os_config_dir}/remotes"

      $os_remotes_template   = 'nullmailer/remotes.erb'
    }
    default: {
      fail("The nullmailer module is not currently supported on ${::operatingsystem}")
    }
  }
}
