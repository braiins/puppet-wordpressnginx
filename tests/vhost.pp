$docroot = '/srv/www/braiins.cz'
class { 'wordpressnginx::php_fpm':
} ->
file { $docroot:
  ensure => present,
} ->
wordpressnginx::vhost { 'braiins.cz':
  docroot                  => '/srv/www/braiins.cz',
  port                     => '80',
  serveraliases            => [ 'braiins.cz' ],
  enable_wp_admin_host_acl => true,
  wp_admin_host_acl        => [ '1.2.3.4', ],
}
