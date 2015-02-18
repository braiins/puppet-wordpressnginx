# wordpressnginx

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with wordpressnginx](#setup)
    * [What wordpressnginx affects](#what-wordpressnginx-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module is able to configure an arbitrary number of wordpress
virtual hosts with nginx as frontend web server.

## Module Description

Wordpress is a blogging and website content management system. The
module configures nginx virtual host for each specified wordpress
site. It also deploys/configures php-fpm package. It is NOT resposible
for deployment or configuration of the actual wordpress instance.

## Setup

### What wordpressnginx affects

* The module optionally deploys a global nginx server configuration (if not already provided by some other module)
* Actual set of nginx wordpress sites.

### Setup Requirements

When nginx has not been deployed and setup yet, the following deploys it:

       class { 'wordpressnginx':
       }

## Usage

The snippet below deploys 1 nginx virtual host for wordpress.

	# PHP fpm deployment
	class { 'wordpressnginx::php_fpm':
	} ->

	# virtual host for nginx
	wordpressnginx::vhost { 'braiins.cz':
	  docroot                  => $www_site_braiins_docroot,
      port                     => '80',
      serveraliases            => [ 'braiins.cz' ],
      require                  => File[$www_site_braiins_docroot],
      enable_wp_admin_host_acl => true,
      wp_admin_host_acl        => [ '1.2.3.4', ],
    }

## Reference

Classes:
* [wordpressnginx](#class-wordpressnginx)
* [wordpressnginx::php_fpm](#class-wordpressnginxphp_fpm)
* [wordpressnginx::params](#class-wordpressnginxparams)
Defines:
* [wordpressnginx::vhost](#class-wordpressnginxvhost)

## Limitations

This module has only been tested on Debian.

## Development

Patches and improvements are welcome as pull requests for the central
project github repository.
