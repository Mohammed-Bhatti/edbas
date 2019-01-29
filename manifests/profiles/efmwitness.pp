class edbas::profiles::efmwitness {

  anchor { 'edbas::profiles::efmwitness::begin': } 
  ->
  class { 'edbas::efmwitness': }
  ->
  anchor { 'edbas::profiles::efmwitness::end': }

}
