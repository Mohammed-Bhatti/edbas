class edbas::create_server (
  $service_manage,
  $initdb_path,
  $datadir,
  $user,
  $group,
  $postgresql_conf_path,
  $port,
  $createdb_path,
  $pg_hba_conf_path,
  $pg_ident_conf_path,
  $psql_path,
  $version,
  $package_ensure,
)
{
  class { 'postgresql::globals':
    version		=> $version,
  }

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
    package_ensure      =>  $package_ensure,
  }
}
