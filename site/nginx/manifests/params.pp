class nginx::params {

  case $::osfamily {
    'debian': {
      $package_name = 'nginx'
      $file_owner = 'root'
      $file_group = 'root'
      $doc_root = $root
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
      $doc_root = $root
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
      $doc_root = $root
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
}
