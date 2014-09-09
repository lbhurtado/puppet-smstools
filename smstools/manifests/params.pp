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

  $global_settings_controlled = {
    'date_filename'    => 2,
    'filename_preview' => 10,
  }  

  $global_settings = {
    'admin_to'            => 639189362340,
    'alarmlevel'          => 4,
    'autosplit'           => 3,
    'blocktime'           => 3600,
    'decode_unicode_text' => no,
    'delaytime'           => 10,
    'errorsleeptime'      => 10,
    'loglevel'            => debug,
    'internal_combine'    => no,
    'national_prefixes'   => 0,
    'receive_before_send' => no,
    'stats_interval'      => 3600,
    'stats_no_zeroes'     => no,
    'validity'            => 255,
  }

  $global_settings_merged = merge($global_settings_controlled, $global_settings)
  $global_setting_keys = keys($global_settings_merged)

  $modem_settings_controlled = {
    'modem_disabled' => false,
  }

  $modem_settings = {
    'incoming'     => 'yes',
    'memory_start' => 1,
    'baudrate'     => '9600',
    'report'       => 'no',
  }

  $modem_settings_merged = merge($modem_settings_controlled, $modem_settings)
  $modem_setting_keys = keys($modem_settings_merged)

  $mode = 1

  case $mode {
    1: { 
      $devices = {
        'GSM1' => { 'device' => '/dev/ttyUSB0', },
      }
    }
    2: {
      $devices = {
        'GSM1' => { 'device' => '/dev/ttyUSB0', },
        'GSM2' => { 'device' => '/dev/ttyUSB1', },
        'GSM3' => { 'device' => '/dev/ttyUSB2', },
      }
    }
    3: {
      $devices = {
        'GSM1' => { 'device' => '/dev/ttyUSB0', 'queues' => 'smart,next,exetel,other', },
        'GSM2' => { 'device' => '/dev/ttyUSB1', 'queues' => 'sun', },
        'GSM3' => { 'device' => '/dev/ttyUSB2', 'queues' => 'globe', },
      }
    }
    default: {
      $devices = {
        'GSM1' => { 'device' => '/tmp/ttyUSB0', },
      }
    }
  }
  $device_keys = keys($devices)
  $device_count = count($devices)

/*
  Lester, create scenarios
    1. default - 1 GSM, no ttyUSB0
        -> create /tmp/ttyUSB0
    2. 1 GSM, w/ ttyS0
    3. single queue
    4. multiple queues
*/
  notice($global_settings)

#
#
#
# Global Settings




}