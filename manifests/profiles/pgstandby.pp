class edbas::profiles::pgstandby {

  $server_package_name = hiera('postgresql::params::server_package_name')
  $version = hiera('postgresql::params::version')
  $datadir = hiera('postgresql::params::datadir')
  $confdir = hiera('postgresql::params::confdir')
  $service_manage = hiera('postgresql::params::service_manage')

  anchor { 'edbas::profiles::pgstandby::begin': } ->

  class { 'postgresql::pgbaseline': }
  ->
  class { 'postgresql::globals':
    server_package_name  =>  $server_package_name,
    manage_package_repo  =>  false,
    version              =>  $version,
    datadir              =>  $datadir,
    confdir              =>  $confdir,
  }
  ->
  class { 'postgresql::pgpkgs': }
  ->
  class { 'postgresql::server': 
    service_manage  =>  $service_manage,
  }
  ->
  anchor { 'edbas::profiles::pgstandby::end': }

  class { 'postgresql::set_hba_rules': }
  ->
  class { 'postgresql::set_postgresql_rules': }
  ->
  class { 'postgresql::set_pg_fw_port': }
}
