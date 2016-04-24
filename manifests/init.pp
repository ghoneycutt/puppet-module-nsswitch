# == Class: nsswitch
#
# This module manages nsswitch.
#
class nsswitch (
  $config_file              = '/etc/nsswitch.conf',
  $ensure_ldap              = 'absent',
  $ensure_vas               = 'absent',
  $vas_nss_module_passwd    = 'vas4',
  $vas_nss_module_group     = 'vas4',
  $vas_nss_module_automount = 'nis',
  $vas_nss_module_netgroup  = 'nis',
  $vas_nss_module_aliases   = '',
  $vas_nss_module_services  = '',
  $passwd                   = $nsswitch::params::passwd,
  $sudoers                  = $nsswitch::params::sudoers,
  $shadow                   = $nsswitch::params::shadow,
  $group                    = $nsswitch::params::group,
  $hosts                    = $nsswitch::params::hosts,
  $automount                = $nsswitch::params::automount,
  $services                 = $nsswitch::params::services,
  $bootparams               = $nsswitch::params::bootparams,
  $aliases                  = $nsswitch::params::aliases,
  $publickey                = $nsswitch::params::publickey,
  $netgroup                 = $nsswitch::params::netgroup,
  $nsswitch_ipnodes         = $nsswitch::params::nsswitch_ipnodes,
  $nsswitch_printers        = $nsswitch::params::nsswitch_printers,
  $nsswitch_auth_attr       = $nsswitch::params::nsswitch_auth_attr,
  $nsswitch_prof_attr       = $nsswitch::params::nsswitch_prof_attr,
  $nsswitch_project         = $nsswitch::params::nsswitch_project,
) inherits nsswitch::params {

  validate_absolute_path($config_file)
  validate_re($ensure_ldap, '^(present|absent)$',
    'Valid values for ensure_ldap are \'absent\' and \'present\'.')
  validate_re($ensure_vas, '^(present|absent)$',
    'Valid values for ensure_vas are \'absent\' and \'present\'.')
  validate_string($vas_nss_module_passwd)
  validate_string($vas_nss_module_group)
  validate_string($vas_nss_module_automount)
  validate_string($vas_nss_module_netgroup)
  validate_string($vas_nss_module_aliases)
  validate_string($vas_nss_module_services)
  validate_string($passwd)
  validate_string($shadow)
  validate_string($sudoers)
  validate_string($group)
  validate_string($hosts)
  validate_string($automount)
  validate_string($services)
  validate_string($bootparams)
  validate_string($aliases)
  validate_string($publickey)
  validate_string($netgroup)
  validate_string($nsswitch_ipnodes)
  validate_string($nsswitch_printers)
  validate_string($nsswitch_auth_attr)
  validate_string($nsswitch_prof_attr)
  validate_string($nsswitch_project)

  file { 'nsswitch_config_file':
    ensure  => file,
    path    => $config_file,
    content => template('nsswitch/nsswitch.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
