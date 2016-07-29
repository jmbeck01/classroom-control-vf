class nginx(
$root = undef,
){

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
