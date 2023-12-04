# == Class: nsswitch
#
# This module manages nsswitch.
#
class nsswitch (
  String $config_file              = '/etc/nsswitch.conf',
  String $ensure_ldap              = 'absent',
  String $ensure_vas               = 'absent',
  String $vas_nss_module_passwd    = 'vas4',
  String $vas_nss_module_group     = 'vas4',
  String $vas_nss_module_automount = 'nis',
  String $vas_nss_module_netgroup  = 'nis',
  $vas_nss_module_aliases          = undef,
  $vas_nss_module_services         = undef,
  String $passwd                   = 'USE_DEFAULTS',
  String $sudoers                  = 'USE_DEFAULTS',
  String $shadow                   = 'USE_DEFAULTS',
  String $group                    = 'USE_DEFAULTS',
  String $hosts                    = 'USE_DEFAULTS',
  String $automount                = 'USE_DEFAULTS',
  String $services                 = 'USE_DEFAULTS',
  String $bootparams               = 'USE_DEFAULTS',
  String $aliases                  = 'USE_DEFAULTS',
  String $publickey                = 'USE_DEFAULTS',
  String $netgroup                 = 'USE_DEFAULTS',
  String $protocols                = 'USE_DEFAULTS',
  String $ethers                   = 'USE_DEFAULTS',
  String $rpc                      = 'USE_DEFAULTS',
  String $nsswitch_ipnodes         = 'USE_DEFAULTS',
  String $nsswitch_printers        = 'USE_DEFAULTS',
  String $nsswitch_auth_attr       = 'USE_DEFAULTS',
  String $nsswitch_prof_attr       = 'USE_DEFAULTS',
  String $nsswitch_project         = 'USE_DEFAULTS',
) {

  case $facts['os']['family'] {
    'Debian','Suse': {
      $default_passwd             = 'files'
      $default_sudoers            = 'files'
      $default_shadow             = 'files'
      $default_group              = 'files'
      $default_hosts              = 'files dns'
      $default_automount          = 'files'
      $default_services           = 'files'
      $default_bootparams         = 'files'
      $default_aliases            = 'files'
      $default_publickey          = 'files'
      $default_netgroup           = 'files'
      $default_protocols          = 'files'
      $default_ethers             = 'files'
      $default_rpc                = 'files'
      $default_nsswitch_ipnodes   = undef
      $default_nsswitch_printers  = undef
      $default_nsswitch_auth_attr = undef
      $default_nsswitch_prof_attr = undef
      $default_nsswitch_project   = undef
    }
    'RedHat': {
      if $facts['os']['release']['major'] == '7' {
        $default_passwd     = 'files sss'
        $default_sudoers    = 'files sss'
        $default_shadow     = 'files sss'
        $default_group      = 'files sss'
        $default_hosts      = 'files dns myhostname'
        $default_automount  = 'files sss'
        $default_services   = 'files sss'
        $default_bootparams = 'nisplus [NOTFOUND=return] files'
        $default_aliases    = 'files nisplus'
        $default_publickey  = 'nisplus'
        $default_netgroup   = 'files sss'
        $default_protocols  = 'files'
        $default_ethers     = 'files'
        $default_rpc        = 'files'
      } else {
        $default_passwd     = 'files'
        $default_sudoers    = 'files'
        $default_shadow     = 'files'
        $default_group      = 'files'
        $default_hosts      = 'files dns'
        $default_automount  = 'files'
        $default_services   = 'files'
        $default_bootparams = 'files'
        $default_aliases    = 'files'
        $default_publickey  = 'files'
        $default_netgroup   = 'files'
        $default_protocols  = 'files'
        $default_ethers     = 'files'
        $default_rpc        = 'files'
      }

      $default_nsswitch_ipnodes   = undef
      $default_nsswitch_printers  = undef
      $default_nsswitch_auth_attr = undef
      $default_nsswitch_prof_attr = undef
      $default_nsswitch_project   = undef
    }
    'Solaris': {
      $default_passwd             = 'files'
      $default_sudoers            = 'files'
      $default_shadow             = 'files'
      $default_group              = 'files'
      $default_hosts              = 'files dns'
      $default_automount          = 'files'
      $default_services           = 'files'
      $default_bootparams         = 'files'
      $default_aliases            = 'files'
      $default_publickey          = 'files'
      $default_netgroup           = 'files'
      $default_protocols          = 'files'
      $default_ethers             = 'files'
      $default_rpc                = 'files'
      $default_nsswitch_ipnodes   = 'files dns'
      $default_nsswitch_printers  = 'user files'
      $default_nsswitch_auth_attr = 'files'
      $default_nsswitch_prof_attr = 'files'
      $default_nsswitch_project   = 'files'
    }
    default: {
      fail("nsswitch supports osfamilies Debian, RedHat, Solaris and Suse. Detected osfamily is <${$facts['os']['release']['major']}>.")
    }
  }

  if $passwd == 'USE_DEFAULTS' {
    $passwd_real = $default_passwd
  } else {
    $passwd_real = $passwd
  }

  if $protocols == 'USE_DEFAULTS' {
    $protocols_real = $default_protocols
  } else {
    $protocols_real = $protocols
  }

  if $ethers == 'USE_DEFAULTS' {
    $ethers_real = $default_ethers
  } else {
    $ethers_real = $ethers
  }

  if $rpc == 'USE_DEFAULTS' {
    $rpc_real = $default_rpc
  } else {
    $rpc_real = $rpc
  }

  if $shadow == 'USE_DEFAULTS' {
    $shadow_real = $default_shadow
  } else {
    $shadow_real = $shadow
  }

  if $sudoers == 'USE_DEFAULTS' {
    $sudoers_real = $default_sudoers
  } else {
    $sudoers_real = $sudoers
  }

  if $group == 'USE_DEFAULTS' {
    $group_real = $default_group
  } else {
    $group_real = $group
  }

  if $hosts == 'USE_DEFAULTS' {
    $hosts_real = $default_hosts
  } else {
    $hosts_real = $hosts
  }

  if $automount == 'USE_DEFAULTS' {
    $automount_real = $default_automount
  } else {
    $automount_real = $automount
  }

  if $services == 'USE_DEFAULTS' {
    $services_real = $default_services
  } else {
    $services_real = $services
  }

  if $bootparams == 'USE_DEFAULTS' {
    $bootparams_real = $default_bootparams
  } else {
    $bootparams_real = $bootparams
  }

  if $aliases == 'USE_DEFAULTS' {
    $aliases_real = $default_aliases
  } else {
    $aliases_real = $aliases
  }

  if $publickey == 'USE_DEFAULTS' {
    $publickey_real = $default_publickey
  } else {
    $publickey_real = $publickey
  }

  if $netgroup == 'USE_DEFAULTS' {
    $netgroup_real = $default_netgroup
  } else {
    $netgroup_real = $netgroup
  }

  if $nsswitch_ipnodes == 'USE_DEFAULTS' {
    $nsswitch_ipnodes_real = $default_nsswitch_ipnodes
  } else {
    $nsswitch_ipnodes_real = $nsswitch_ipnodes
  }

  if $nsswitch_printers == 'USE_DEFAULTS' {
    $nsswitch_printers_real = $default_nsswitch_printers
  } else {
    $nsswitch_printers_real = $nsswitch_printers
  }

  if $nsswitch_auth_attr == 'USE_DEFAULTS' {
    $nsswitch_auth_attr_real = $default_nsswitch_auth_attr
  } else {
    $nsswitch_auth_attr_real = $nsswitch_auth_attr
  }

  if $nsswitch_prof_attr == 'USE_DEFAULTS' {
    $nsswitch_prof_attr_real = $default_nsswitch_prof_attr
  } else {
    $nsswitch_prof_attr_real = $nsswitch_prof_attr
  }

  if $nsswitch_project == 'USE_DEFAULTS' {
    $nsswitch_project_real = $default_nsswitch_project
  } else {
    $nsswitch_project_real = $nsswitch_project
  }

  file { 'nsswitch_config_file':
    ensure  => file,
    path    => $config_file,
    content => template('nsswitch/nsswitch.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
