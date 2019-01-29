class edbas::profiles::edbasprimary {

  anchor { 'edbas::profiles::edbasprimary::begin': } ->
  class {'edbas::set_edbas_repo': }
  ->
  # Comment this if running edbas and pgpool on same server
  class {'edbas::edbaspkgs': }
  ->
  class { 'edbas::edbasbaseline': }
  ->
  class { 'edbas::create_server': }
  #->
  #class { 'edbas::create_db': }
  ->
  class { 'edbas::ssl_copy_files': }
  ->
  class { 'edbas::create_roles': }
  ->
  class { 'edbas::create_encfs': }
  ->
  anchor { 'edbas::profiles::edbasprimary::end': }
  
  #class { 'edbas::set_postgresql_rules': }
  class { 'edbas::set_common_postgresql_rules': }
  ->
  #class { 'edbas::set_overrides_postgresql_rules': }
  #->
  class { 'edbas::set_hba_rules': }
  ->
  # Comment this if running edbas and pgpool on same server
  class { 'edbas::set_pg_fw_port': }
  ->
  class { 'edbas::set_privs': }
  ->
  class { 'edbas::set_cronchks': }
  ->
  class { 'edbas::set_logrotate': }
  #class { 'edbas::pgpoolconfig': }
  #->
  #class { 'edbas::service_stop': }
}
