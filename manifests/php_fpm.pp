# == Class: wordpressnginx::php_fpm
#
# Deploys PHP FPM-CGI service. Optionally, the PHP ini can be
# customized by providing optional content.
#
# === Parameters
#
# [*php_service*]
#   Name of the service in the system
# [*php_pkg*]
#   Name of the system pack to be installed
# [*conf_dir*]
#   Configuration directory
# [*php_ini_content*]
#   Optional content of the PHP ini file
# [*php_ini_source*]
#   Optional source of the PHP ini file
#
# === Examples
#
#  class { 'wordpressnginx::php_fpm':
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
class wordpressnginx::php_fpm (
  $php_service     = $wordpressnginx::params::php_service,
  $php_pkg         = $wordpressnginx::params::php_pkg,
  $conf_dir        = $wordpressnginx::params::conf_dir,
  $php_ini_content = undef,
  $php_ini_source  = undef,
) inherits wordpressnginx::params
{
  include nginx
  include nginx::params

  package { [ $php_pkg, 'php5-mysql' ]:
    ensure => present,
  } ->
  package { [ 'php5-gd', 'php5-curl' ]:
    ensure => present,
  } ->
  service { $php_service:
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
  }
  # Custom PHP ini file
  if ($php_ini_source != undef) or ($php_ini_content != undef) {
    file { "${conf_dir}/php.ini":
      content => $php_ini_content,
      source  => $php_ini_source,
      require => Package[$php_pkg],
      notify  => Service[$php_service]
    }
  }

  @file { "${nginx::config_dir}/php-wordpress.conf":
    content => template('wordpressnginx/php-wordpress.conf.erb'),
    mode    => $nginx::config_file_mode,
    owner   => $nginx::config_file_owner,
    group   => $nginx::config_file_group,
    require => [ Package['nginx'], ],
  }
}
