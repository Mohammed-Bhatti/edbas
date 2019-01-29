class edbas::set_cronchks (
) {
  # chkdata.sh for Vuln ID: V-68999
  file { '/root/chkdata.sh':
    ensure  => present,
    source  => 'puppet:///modules/edbas/chkdata.sh',
    mode    => '700',
    owner   => 'root',
    group   => 'root',
    replace => true,
  }

  cron { 'chkdata': 
    command	=> '/root/chkdata.sh',
    user	=> 'root',
    minute	=> '*/15',
  }
}
