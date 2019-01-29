class edbas::role::edbasstaging {

  anchor { 'railgun::role::edbasstaging::begin': }
  ->  class { 'edbas::profiles::edbasstaging': }
  ->  anchor { 'railgun::role::edbasstaging::end': }

}

