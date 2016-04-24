class nsswitch::params {
  case $::osfamily {
    'Debian','Suse': {
      $passwd             = 'files'
      $sudoers            = 'files'
      $shadow             = 'files'
      $group              = 'files'
      $hosts              = 'files dns'
      $automount          = 'files'
      $services           = 'files'
      $bootparams         = 'files'
      $aliases            = 'files'
      $publickey          = 'files'
      $netgroup           = 'files'
      $nsswitch_ipnodes   = undef
      $nsswitch_printers  = undef
      $nsswitch_auth_attr = undef
      $nsswitch_prof_attr = undef
      $nsswitch_project   = undef
    }
    'RedHat': {
      if $::operatingsystemmajrelease == '7' {
        $passwd     = 'files sss'
        $sudoers    = 'files sss'
        $shadow     = 'files sss'
        $group      = 'files sss'
        $hosts      = 'files dns myhostname'
        $automount  = 'files sss'
        $services   = 'files sss'
        $bootparams = 'nisplus [NOTFOUND=return] files'
        $aliases    = 'files nisplus'
        $publickey  = 'nisplus'
        $netgroup   = 'files sss'
      } else {
        $passwd     = 'files'
        $sudoers    = 'files'
        $shadow     = 'files'
        $group      = 'files'
        $hosts      = 'files dns'
        $automount  = 'files'
        $services   = 'files'
        $bootparams = 'files'
        $aliases    = 'files'
        $publickey  = 'files'
        $netgroup   = 'files'
      }

      $nsswitch_ipnodes   = undef
      $nsswitch_printers  = undef
      $nsswitch_auth_attr = undef
      $nsswitch_prof_attr = undef
      $nsswitch_project   = undef
    }
    'Solaris': {
      $passwd             = 'files'
      $sudoers            = 'files'
      $shadow             = 'files'
      $group              = 'files'
      $hosts              = 'files dns'
      $automount          = 'files'
      $services           = 'files'
      $bootparams         = 'files'
      $aliases            = 'files'
      $publickey          = 'files'
      $netgroup           = 'files'
      $nsswitch_ipnodes   = 'files dns'
      $nsswitch_printers  = 'user files'
      $nsswitch_auth_attr = 'files'
      $nsswitch_prof_attr = 'files'
      $nsswitch_project   = 'files'
    }
    default: {
      fail("nsswitch supports osfamilies Debian, RedHat, Solaris and Suse. Detected osfamily is <${::osfamily}>.")
    }
  }
}