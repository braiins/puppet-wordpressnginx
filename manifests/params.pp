# == Class: wordpressnginx::params
#
# This class defines default parameters of the main wordpressnginx class
#
#
# === Examples
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class wordpressnginx::params {
  $php_service = 'php5-fpm'
  $php_pkg     = $php_service
  $conf_dir    = '/etc/php5/fpm'
}
