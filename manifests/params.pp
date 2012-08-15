
class nullmailer::params inherits nullmailer::default {

  $package            = module_param('package')
  $package_ensure     = module_param('package_ensure')
  $service            = module_param('service')
  $service_ensure     = module_param('service_ensure')

  #---

  $config_dir         = module_param('config_dir')

  $remotes_dir        = module_param('remotes_dir')
  $remotes_template   = module_param('remotes_template')
  $remotes            = module_array('remotes')
}
