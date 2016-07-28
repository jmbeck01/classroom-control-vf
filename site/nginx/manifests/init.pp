class nginx {
case $::osfamily {
  'debian': {
    $package_name = 'nginx'
    $file_owner = 'root'
    $file_group = 'root'
    $doc_root = '/var/www'
    $config_dir = '/etc/nginx'
    $server_block_dir = '/etc/nginx/conf.d'
    $log_dir = '/var/log/nginx'
    $service_name = 'nginx'
    $runas_user = 'www-data'
  }
  'windows': {
    $package_name = 'nginx-service'
    $file_owner = 'Administrators'
    $file_group = 'Administrators'
    $doc_root = 'C:/ProgramData/nginx/html'
    $config_dir = 'C:/ProgramData/nginx'
    $server_block_dir = 'C:/ProgramData/nginx/conf.d'
    $log_dir = 'C:/ProgramData/nginx/logs'
    $service_name = 'nginx'
    $runas_user = 'nobody'
  }
  'redhat': {
    $package_name = 'nginx'
    $file_owner = 'root'
    $file_group = 'root'
    $doc_root = '/var/www'
    $config_dir = '/etc/nginx'
    $server_block_dir = '/etc/nginx/conf.d'
    $log_dir = '/var/log/nginx'
    $service_name = 'nginx'
    $runas_user = 'nginx'
  }
  default: {
      fail("Operating system #{operatingsystem} is not supported.")
  }
}

  File {
    owner => 'root',
    group => 'root',
    mode => '0664',
  }
  package { $package_name:
    ensure => 'present',
  }

  file { "${config_dir}/nginx.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { "${server_block_dir}/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    require => Package['$package_name'],
  }
  file { $doc_root:
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0775',
  }
  file { "${doc_root}/index.html":
    ensure => file,
    #source => 'puppet:///modules/nginx/index.html',
    content => template('nginx/index.html.erb'),
  }
  file { "${doc_root}/example.js":
    ensure => file,
    source => 'puppet:///modules/nginx/clock.js',
  }
  service { $service_name:
    ensure => running,
    enable => true,
  }
  

}
