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

  $providers = {
    'smart' => [63813,63907,63908,63909,63910,63912,63918,63919,63920,63921,63928,63929,63930,63938,63939,63946,63947,63948,63949,63989,63998,63999],
    'sun'   => [63922,63923,63925,63932,63933,63934,63942,63943],
    'globe' => [63817,63905,63906,63915,63916,63917,63925,63926,63927,63935,63936,63937,63994,63996,63997],
    'next'  => [63977,63979],
    'exetel'=> [63973,63974],
    'other' => [0,1,2,3,4,5,6,7,8,9]
  }
  $queues = keys($providers)

  $devices = {
    'GSM1' => {
      'device' => '/dev/ttyUSB0',
      'queues' => ['smart', 'next', 'exetel', 'other'],
    },
    'GSM2' => {
      'device' => '/dev/ttyUSB1',
      'queues' => ['globe'],
    },
    'GSM3' => {
      'device' => '/dev/ttyUSB2',
      'queues' => ['sun'],
    },
  }
  $modem = keys($devices)

  notice ($modem)
}