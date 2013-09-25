class nsswitch::solaris {

  if $::kernelrelease == 5.11 {
    exec { 'pre-nscfg':
      path        => ['/usr/bin'],
      command     => '/usr/bin/cp /etc/nsswitch.conf /tmp/smf-workaround',
      subscribe   => File['/etc/nsswitch.conf'],
      refreshonly => true
    }

    exec { 'nscfg':
      path        => ['/usr/sbin'],
      onlyif      => 'nscfg import -f svc:/system/name-service/switch:default',
      command     => 'svcadm refresh name-service/switch',
      subscribe   => Exec['pre-nscfg'],
      refreshonly => true,
      before      => Exec['post-nscfg']
    }

    exec { 'post-nscfg':
      path        => ['/usr/bin'],
      onlyif      => '/usr/bin/sleep 2',
      command     => 'mv /tmp/smf-workaround /etc/nsswitch.conf',
      subscribe   => Exec['nscfg'],
      refreshonly => true
    }
  }
}
