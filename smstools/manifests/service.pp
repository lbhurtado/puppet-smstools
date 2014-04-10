# == Class smstools::service
#
# This class is meant to be called from smstools
# It ensure the service is running
#
class smstools::service {

  service { $smstools::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
