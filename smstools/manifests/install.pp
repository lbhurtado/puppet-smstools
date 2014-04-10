# == Class smstools::install
#
class smstools::install {

  package { $smstools::package_name:
    ensure => present,
  }
}
