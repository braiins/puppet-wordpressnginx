# == Class: wordpressnginx
#
# This class configures nginx server.
#
# This class doesn't have to be instantiated if the local site already
# has a top level server configuration (class nginx). That is
# compatible with the settings required by wordpress.
#
# === Parameters
#
#
# === Variables
#
#
# [*reverse_proxy_ip_list*]
#   List of IP addresses that are a set of trusted proxies for which
#   the real IP http header (X-Real_IP) will be accepted.
# [*php_socket_path*]
#   Optional path for the PHP fpm socket
#
# === Examples
#
#  class { wordpressnginx:
#
#  }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class wordpressnginx(
  $reverse_proxy_ip_list=[],
  $php_socket_path = '/var/run/php5-fpm.sock'
) {
  class { 'nginx':
    template => 'wordpressnginx/nginx.conf.erb'
  }

  # Remove the default site
  file { "${nginx::config_dir}/sites-enabled/default":
    ensure => absent,
    notify => Service['nginx'],
  }

}
