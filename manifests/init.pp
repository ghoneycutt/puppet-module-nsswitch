# == Class: nsswitch
#
# This module manages nsswitch.
#
class nsswitch (
  $config_file    = '/etc/nsswitch.conf',
  $ensure_ldap    = 'absent',
  $ensure_vas     = 'absent',
  $vas_nss_module = 'vas4',
) {

  validate_absolute_path($config_file)
  validate_re($ensure_ldap, '^(present|absent)$',
    'Valid values for ensure_ldap are \'absent\' and \'present\'.')
  validate_re($ensure_vas, '^(present|absent)$',
    'Valid values for ensure_vas are \'absent\' and \'present\'.')
  validate_re($vas_nss_module, '^vas(3|4)$',
    'Valid values for vas_nss_module are \'vas3\' and \'vas4\'.')

  if $::operatingsystem == 'Solaris' and $::operatingsystemrelease =~ /^5\.11/ {

    file { '/etc/svccfg.d' :
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      before => File[ 'nsswitch_config_file' ],
    }
    file { 'nsswitch_config_file':
      ensure  => file,
      path    => $config_file,
      content => template('nsswitch/nsswitch.svccfg.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify  => Exec[ 'nsswitch_svccfg' ],
    }
    exec { 'nsswitch_svccfg' :
      command     => $config_file,
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      refreshonly => true,
    }

  } else {

    file { 'nsswitch_config_file':
      ensure  => file,
      path    => $config_file,
      content => template('nsswitch/nsswitch.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}
