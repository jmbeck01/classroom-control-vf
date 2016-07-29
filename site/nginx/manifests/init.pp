class nginx(
  $package_name = $nginx::params::package_name,
  $file_owner = $nginx::params::file_owner,
  $file_group = $nginx::params::file_group,
  $doc_root = $nginx::params::doc_root,
  $config_dir = $nginx::params::config_dir,
  $server_block_dir = $nginx::params::server_block_dir,
  $log_dir = $nginx::params::log_dir,
  $service_name = $nginx::params::service_name,
  $runas_user = $nginx::params::runas_user,
)inherits nginx::params{

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
    require => Package[$package_name],
    notify => Service[$service_name],
  }
  file { "${server_block_dir}/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
    require => Package[$package_name],
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
