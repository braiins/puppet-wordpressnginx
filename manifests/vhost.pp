# == Define: wordpressnginx::vhost
#
# Generates a vhost for wordpress
#
# === Parameters
#
# [*port*]
#    port where this vhost should listen
# [*priority*]
#    priority of the site configuration file
# [*docroot*]
#    document root of the vhost site
# [*serveraliases*]
#    list of aliases of the vhost
# [*enable_wp_admin_host_acl*]
#    when true - administration interface is protected by an ACL
# [*wp_admin_host_acl*]
#    list of hosts allowed to access the admin interface
#
# === Examples
#
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
define wordpressnginx::vhost(
  $port,
  $priority        = '50',
  $docroot,
  $serveraliases,
  $enable_wp_admin_host_acl = false,
  $wp_admin_host_acl = [],
) {
  include nginx
  include nginx::params

  $site_config_filename = "${priority}-${name}.conf"
  $site_config_pathname = "${nginx::vdir}/${site_config_filename}"
  file { $site_config_pathname:
    content => template('wordpressnginx/vhost.conf.erb'),
    mode    => $nginx::config_file_mode,
    owner   => $nginx::config_file_owner,
    group   => $nginx::config_file_group,
    require => [ Package['nginx'], File[$docroot] ],
    notify  => Service['nginx'],
  }

  # Symlink of the enabled site
  file { "${nginx::config_dir}/sites-enabled/${site_config_filename}":
    ensure  => 'link',
    target  => $site_config_pathname,
    require => [ Package['nginx'], ],
    notify  => Service['nginx'],
  }

  # First wordpress vhost instantiates the php include
  realize File[ "${nginx::config_dir}/php-wordpress.conf" ]
}
