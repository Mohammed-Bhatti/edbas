class edbas::profiles::pemserver {
  anchor { 'edbas::profiles::pemserver::begin': } 
  ->
  class { 'edbas::create_pem_dir': }
  ->
  class { 'edbas::create_pem_server': }
  ->
  anchor { 'edbas::profiles::pemserver::end': }
}
