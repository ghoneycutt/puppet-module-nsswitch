# ghoneycutt/nsswitch

[![Build Status](
https://api.travis-ci.org/ghoneycutt/puppet-module-nsswitch.png?branch=master)](https://travis-ci.org/ghoneycutt/puppet-module-nsswitch)

Puppet module to manage nsswitch that optionally allows for LDAP and VAS integration.

===

# Compatibility

Puppet v3 with Ruby 1.8.7, 1.9.3, and 2.0.0

  * EL 5
  * EL 6
  * Solaris 10
  * Solaris 11

===

# Parameters

config_file
-----------
Path to configuration file.

- *Default*: `/etc/nsswitch.conf`

ensure_ldap
-----------
Should LDAP be used? Valid values are 'absent' and 'present'

- *Default*: 'absent'

ensure_vas
----------
Should VAS (Quest Authentication Services) be used? Valid values are 'absent' and 'present'.

- *Default*: 'absent'

vas_nss_module
--------------
Name of NSS module to use for VAS.

- *Default*: 'vas4'

vas_nss_module_passwd
---------------------
Source for vas to be included in the passwd database.

- *Default*:'vas4'

vas_nss_module_group
--------------------
Source for vas to be included in the group database.

- *Default*:'vas4'

vas_nss_module_automount
------------------------
Source for vas to be included in the automount database.

- *Default*:'nis'

vas_nss_module_netgroup
-----------------------
Source for vas to be included in the netgroup database.

- *Default*:'nis'

vas_nss_module_aliases
----------------------
Source for vas to be included in the aliases database.

- *Default*:''

vas_nss_module_services
-----------------------
Source for vas to be included in the services database.

- *Default*: ''

nsswitch_ipnodes
----------------
String of list of sources for ipnodes database. 'USE_DEFAULTS' allows the module to choose defaults based on the platform.

- *Default*: 'USE_DEFAULTS'

nsswitch_printers
-----------------
String of list of sources for printers database. 'USE_DEFAULTS' allows the module to choose defaults based on the platform.

- *Default*: 'USE_DEFAULTS'

nsswitch_auth_attr
------------------
String of list of sources for auth_attr database. 'USE_DEFAULTS' allows the module to choose defaults based on the platform.

- *Default*: 'USE_DEFAULTS'

nsswitch_prof_attr
------------------
String of list of sources for prof_attr database. 'USE_DEFAULTS' allows the module to choose defaults based on the platform.

- *Default*: 'USE_DEFAULTS'

nsswitch_project
----------------
String of list of sources for project database. 'USE_DEFAULTS' allows the module to choose defaults based on the platform.

- *Default*: 'USE_DEFAULTS'
