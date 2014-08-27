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
  $config_dir      = "/etc/$package_name"
  $binaries_dir    = '/usr/local/bin'
  $sms_dir         = '/var/spool/sms'

  $config          = '/etc/smsd.conf'
  $config_template = 'smstools/smsd.conf.erb'
  
  $accessor        = ['blacklist', 'whitelist']
  $handler         = ['eventhandler', 'checkhandler', 'alarmhandler']

  $prefix = {
    'smart' => ['0813','0907','0908','0909','0910','0912','0918','0919','0920','0921','0928','0929','0930','0938','0939','0946','0947','0948','0949','0989','0998','0999'],
    'sun'   => ['0922','0923','0925','0932','0933','0934','0942','0943'],
    'globe' => ['0817','0905','0906','0915','0916','0917','0925','0926','0927','0935','0936','0937','0994','0996','0997'],
    'next'  => ['0977','0979'],
    'exetel'=> ['0973','0974'],
  }
  $telco = keys($prefix)
}