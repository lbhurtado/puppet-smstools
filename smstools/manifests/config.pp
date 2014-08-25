# == Class smstools::config
#
# This class is called from smstools
#
class smstools::config {
  
  file { '/etc/smsd.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('smstools/smsd.conf.erb'),
  }

}
