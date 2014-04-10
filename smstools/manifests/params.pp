# == Class smstools::params
#
# This class is meant to be called from smstools
# It sets variables according to platform
#
class smstools::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'smstools'
      $service_name = 'smstools'
    }
    'RedHat', 'Amazon': {
      $package_name = 'smstools'
      $service_name = 'smstools'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
