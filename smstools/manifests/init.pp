# == Class: smstools
#
# Full description of class smstools here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class smstools (
  $package_name    = $smstools::params::package_name,
  $service_name    = $smstools::params::service_name,
  $accessor        = $smstools::params::accessor,
  $global_settings = $smstools::params::global_settings,
  $modem_settings  = $smstools::params::modem_settings,
  $mode			   = $smstools::params::mode,

) inherits smstools::params {

  # validate parameters here

  class { 'smstools::install': } ->
  class { 'smstools::config': } ~>
  class { 'smstools::service': } ->
  Class['smstools']
}
