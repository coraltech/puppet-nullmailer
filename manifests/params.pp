
class nullmailer::params {

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    debian: {}
    ubuntu: {
      $nullmailer_package = 'nullmailer'
      $nullmailer_version = '1:1.05-1'

      $config_path        = '/etc/nullmailer'
      $remotes_path       = "${config_path}/remotes"
    }
    centos: {}
    redhat: {}
  }
}
