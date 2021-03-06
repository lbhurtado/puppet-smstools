# == Class smstools::config
#
# This class is called from smstools
#

class smstools::config {
  
  file { $::smstools::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($::smstools::config_template),
  }
 
  file { $::smstools::config_dir:
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { $::smstools::sms_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  define create_accessor {
    file { "$::smstools::config_dir/${title}":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      source  => "puppet:///modules/smstools/${title}",
      require => File[$::smstools::config_dir]
    }
  }

  create_accessor { $::smstools::accessor: }

  define create_binary {
    file { "$::smstools::binaries_dir/${title}":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0755',
      source  => "puppet:///modules/smstools/${title}",
    }
  }
  
  create_binary { $::smstools::handler: }

  create_binary { $::smstools::script: }

  define create_queue {
    file { "$::smstools::sms_dir/${title}":
      ensure  => directory,
      owner   => 0,
      group   => 0,
      mode    => '0666',
      require => File[$::smstools::sms_dir]
    }
  }

  create_queue { $::smstools::queues: }

  define create_tty {
    file { "/tmp/tty${title}":
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0666',
    }
  }

  create_tty { $::smstools::modem: }

}
