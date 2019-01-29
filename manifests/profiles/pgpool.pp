class edbas::profiles::pgpool {

  anchor { 'edbas::profiles::pgpool::begin': } ->

  # Comment this line out if running pgPool on the same server
  #class { 'edbas::pgpoolbaseline': }
  #->
  class { 'edbas::edbaspkgs': }
  ->
  class { 'edbas::pgpoolconfig': }
  ->
  class { 'edbas::set_pg_fw_port': }
  ->
  class { 'edbas::set_privs': }
  ->
  anchor { 'edbas::profiles::pgpool::end': }
}
