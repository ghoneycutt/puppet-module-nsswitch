# This class is applied on Solaris kernelrelease 5.11
# database sources and their lookup order  are  specified in SMF;
# svc:/system/name-service/switch. /etc/nsswitch.conf is obsolete,
# but regenerated from SMF for backward compatibility.
class nsswitch::solaris11 (
  $ensure_ldap,
  $ensure_vas,
  $vas_nss_module_passwd,
  $vas_nss_module_group,
  $vas_nss_module_automount,
  $vas_nss_module_netgroup,
  $vas_nss_module_aliases,
  $vas_nss_module_services,
  $nsswitch_ipnodes_real,
  $nsswitch_printers_real,
  $nsswitch_auth_attr_real,
  $nsswitch_prof_attr_real,
  $nsswitch_project_real,

) {

  $passwd_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %><% if @ensure_vas == 'present' %> <%= vas_nss_module_passwd %><% end %>")
  $shadow_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %>")
  $group_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %><% if @ensure_vas == 'present' %> <%= @vas_nss_module_group %><% end %>")
  $sudoers_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %>")
  $protocols_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %>")
  $services_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %><% if @ensure_vas == 'present' %><% if @vas_nss_module_services != '' %> <%= @vas_nss_module_services %><% end %><% end %>")
  $netgroup_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %><% if @ensure_vas == 'present' %><% if @vas_nss_module_netgroup != '' %> <%= @vas_nss_module_netgroup %><% end %><% end %>")
  $automount_line = inline_template("files<% if @ensure_ldap == 'present' %> ldap<% end %><% if @ensure_vas == 'present' %><% if @vas_nss_module_automount != '' %> <%= @vas_nss_module_automount %><% end %><% end %>")
  $aliases_line = inline_template("files<% if @ensure_vas == 'present' %><% if @vas_nss_module_aliases != '' %> <%= @vas_nss_module_aliases %><% end %><% end %>")

  nsswitch { 'Solaris11_switch':
    password  => $passwd_line,
    group     => $group_line,
    sudoer    => $sudoers_line,
    host      => 'files dns',
    bootparam => 'files',
    ether     => 'files',
    netmask   => 'files',
    network   => 'files',
    protocol  => $protocols_line,
    rpc       => 'files',
    service   => $services_line,
    netgroup  => $netgroup_line,
    publickey => 'files',
    automount => $automount_line,
    alias     => $aliases_line,
    printer   => $nsswitch_printers_real,
    auth_attr => $nsswitch_auth_attr_real,
    prof_attr => $nsswitch_prof_attr_real,
    project   => $nsswitch_project_real,
  }

  service { 'switch' :
    name      => 'name-service/switch',
    ensure    => running,
  }
}
