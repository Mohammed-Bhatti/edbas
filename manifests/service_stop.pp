class edbas::service_stop {

  service { 'postgresql':
    ensure	=> 'stopped',
    enable	=> 'false',
  }
}
