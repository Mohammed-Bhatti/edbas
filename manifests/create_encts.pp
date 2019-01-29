class edbas::create_encts (
  $location,
  $spcname,
  $pgport,
) {

  notify { "PSQL PATH ${postgresql::server::psql_path}": }
  $connect_settings_hash = {
    'PGUSER'		=> 'enterprisedb',
    'PGPORT'		=> $pgport,
    'PGDATABASE' 	=> 'edb'
  }

  postgresql::server::tablespace { "$spcname":
    location		=> $location,
    connect_settings	=> $connect_settings_hash,
    require	=> Class['postgresql::server'],
  }
}
