class edbas::profiles::pgglobals {

  $server_package_name = hiera('postgresql::params::server_package_name')
  $contrib_package_name = hiera('postgresql::params::package_ensure')
  $devel_package_name = hiera('postgresql::params::service_ensure')
  $listen_addresses = hiera('postgresql::params::listen_addresses')
  $perl_package_name = hiera('postgresql::params::ip_mask_allow_all_user')
  $plpython_package_name = hiera('postgresql::params::initdb_path')
  $postgis_package_name = hiera('postgresql::params::log_line_prefix')
  $version = hiera('postgresql::params::version')
  $datadir = hiera('postgresql::params::datadir')
  $confdir = hiera('postgresql::params::confdir')

  anchor { 'edbas::profiles::pgglobals::begin': } ->

  class { 'postgresql::globals':
    server_package_name  =>  $server_package_name,
    contrib_package_name =>  $contrib_package_name,
    devel_package_name   =>  $devel_package_name,
    docs_package_name    =>  $docs_package_name,
    perl_package_name    =>  $perl_package_name,
    plpython_package_name => $plpython_package_name,
    postgis_package_name =>  $postgis_package_name,
    manage_package_repo  =>  false,
    version              =>  $version,
    datadir              =>  $datadir,
    confdir              =>  $confdir,
  }
  ->

  anchor { 'edbas::profiles::pgglobals::end': }
}
