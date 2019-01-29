class edbas::role::pemserver {

  anchor { 'railgun::role::pemserver::begin': } ->

    class { 'edbas::profiles::pemserver': }
    ->
    anchor { 'railgun::role::pemserver::end': }

}

