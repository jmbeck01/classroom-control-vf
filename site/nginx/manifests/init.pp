class nginx {

  package { 'nginx':
    ensure => 'present',
  }

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0664',
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  file { '/var/www':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html
  }
  file { '/var/www/example.js':
    ensure => file,
    source => 'puppet:///modules/nginx/clock.js
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    require File['/etc/nginx/nginx.conf']
  }
  

}
