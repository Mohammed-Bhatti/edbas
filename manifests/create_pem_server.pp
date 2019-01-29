class edbas::create_pem_server (
  $service_manage		= hiera(edbas::create_pem_server::service_manage),
  $initdb_path			= hiera(edbas::create_pem_server::initdb_path),
  $datadir			= hiera(edbas::create_pem_server::datadir),
  $user				= hiera(edbas::create_pem_server::user),
  $group			= hiera(edbas::create_pem_server::group),
  $postgresql_conf_path		= hiera(edbas::create_pem_server::postgresql_conf_path),
  $port				= hiera(edbas::create_pem_server::port),
  $createdb_path		= hiera(edbas::create_pem_server::createdb_path),
  $pg_hba_conf_path		= hiera(edbas::create_pem_server::pg_hba_conf_path),
  $pg_ident_conf_path		= hiera(edbas::create_pem_server::pg_ident_conf_path),
  $psql_path			= hiera(edbas::create_pem_server::psql_path),
  $version			= hiera(edbas::create_pem_server::version),
  $package_ensure		= hiera(edbas::create_pem_server::package_ensure),
)
{
  file { $datadir :
    ensure	=> 'directory',
    owner	=> $user,
    group	=> $group,
    mode	=> '0700',
  }

#  class { 'postgresql::globals':
#    version		=> $version,
#  }

  class { 'postgresql::server':  
    service_manage       => $service_manage,
    initdb_path          => $initdb_path,
    datadir              => $datadir,
    user                 => $user,
    group                => $group,
    postgresql_conf_path => $postgresql_conf_path,
    port                 => $port,
    createdb_path        => $createdb_path,
    pg_hba_conf_path     => $pg_hba_conf_path,
    pg_ident_conf_path   => $pg_ident_conf_path,
    psql_path            => $psql_path,
    package_ensure       => $package_ensure,
  }
}
