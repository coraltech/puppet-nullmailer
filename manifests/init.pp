# Class: nullmailer
#
#   This module manages the NullMailer MTA service.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#  $nullmailer_version = $nullmailer::params::nullmailer_version
#
# Actions:
#
#  Installs, configures, and manages the NullMailer MTA service.
#
# Requires:
#
# Sample Usage:
#
#   $emailserver1 = {
#      host     => 'mail.example.com',
#      port     => 25,
#      protocol => 'smtp',
#      user     => 'me@example.com',
#      password => 'mypassword',
#   }
#
#   class { 'nullmailer':
#     remotes => [ $emailserver1 ],
#   }
#
# [Remember: No empty lines between comments and class definition]
class nullmailer (

  $remotes            = [],
  $nullmailer_package = $nullmailer::params::nullmailer_package,
  $nullmailer_version = $nullmailer::params::nullmailer_version,
  $config_path        = $nullmailer::params::config_path,
  $remotes_path       = $nullmailer::params::remotes_path,

) inherits nullmailer::params {

  #-----------------------------------------------------------------------------
  # Install

  if ! $nullmailer::params::nullmailer_package or ! $nullmailer_version {
    fail('Nullmailer package and version must be defined')
  }
  package { $nullmailer::params::nullmailer_package:
    ensure => $nullmailer_version,
  }

  #-----------------------------------------------------------------------------
  # Configure

  if $remotes_path {
    file { $remotes_path:
      owner    => "mail",
      group    => "mail",
      mode     => 600,
      content  => template('nullmailer/remotes.erb'),
      notify   => Service['nullmailer'],
    }
  }

  #-----------------------------------------------------------------------------
  # Manage

  service {
    'nullmailer':
      enable    => true,
      ensure    => ! $remotes_path or empty($remotes) ? {
        true    => 'stopped',
        default => 'running',
      },
      subscribe => Package['nullmailer'],
  }
}
