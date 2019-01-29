class edbas::profiles::pgadditional {

  anchor { 'edbas::profiles::pgadditional::begin': } ->

  class { 'postgresql::server::contrib': }
  ->
  class { 'postgresql::server::postgis': }
  ->
  anchor { 'edbas::profiles::pgadditional::end': }
}
