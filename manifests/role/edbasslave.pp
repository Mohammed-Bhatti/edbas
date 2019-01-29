class edbas::role::edbasslave {

  anchor { 'railgun::role::edbasslave::begin': }
  ->  class { 'edbas::profiles::edbasslave': }
  ->  anchor { 'railgun::role::edbasslave::end': }

}

