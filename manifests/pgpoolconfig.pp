class edbas::pgpoolconfig (
  $listen_address	= hiera('postgresql::pgpool::listen_address'),
  $log_destination	= hiera('postgresql::pgpool::log_destination'),
  $port			= hiera('postgresql::pgpool::port'),
  $backend_hostname0	= hiera('postgresql::pgpool::backend_hostname0'),
  $backend_hostname1	= hiera('postgresql::pgpool::backend_hostname1'),
  $backend_hostname2	= hiera('postgresql::pgpool::backend_hostname2'),
  $backend_port1	= hiera('postgresql::pgpool::backend_port1'),
  $log_hostname		= hiera('postgresql::pgpool::log_hostname'),
  $syslog_facility	= hiera('postgresql::pgpool::syslog_facility'),
  $sr_check_user	= hiera('postgresql::pgpool::sr_check_user'),
  $sr_check_password	= hiera('postgresql::pgpool::sr_check_password'),
  $health_check_user	= hiera('postgresql::pgpool::health_check_user'),
  $health_check_password = hiera('postgresql::pgpool::health_check_password'),
  $delegate_IP		= hiera('postgresql::pgpool::delegate_IP'),
  $netmask		= hiera('postgresql::pgpool::netmask'),
  $heartbeat_device0	= hiera('postgresql::pgpool::heartbeat_device0'),
  #$heartbeat_device1	= hiera('postgresql::pgpool::heartbeat_device1'),
  $heartbeat_destination0 = hiera('postgresql::pgpool::heartbeat_destination0'),
  $other_pgpool_hostname0 = hiera('postgresql::pgpool::other_pgpool_hostname0'),
  $heartbeat_destination1 = hiera('postgresql::pgpool::heartbeat_destination1'),
  $other_pgpool_hostname1 = hiera('postgresql::pgpool::other_pgpool_hostname1'),
  $recovery_user	= hiera('postgresql::pgpool::recovery_user'),
  $recovery_password	= hiera('postgresql::pgpool::recovery_password'),
  $md5_password		= hiera('postgresql::pgpool::md5_password'),
  $wd_hostname		= hiera('postgresql::pgpool::wd_hostname'),
){

  #file { '/etc/pgpool-II-96/pgpool.conf':
  #file { '/etc/sysconfig/edb/pgpool3.5/pgpool.conf':
  file { '/etc/sysconfig/edb/pgpool3.6/pgpool.conf':
    ensure	=>  present,
    content	=>  template('edbas/pgpool.conf.erb'),
    mode	=>  '644',
    owner	=>  'root',
    group	=>  'root',
  }

  file { '/bin/ip_w':
    ensure	=>  present,
    source	=>  'puppet:///modules/edbas/ip_w',
    mode	=>  '755',
    owner	=>  'root',
    group	=>  'root',
  }

  file { '/bin/arping_w':
    ensure	=>  present,
    source	=>  'puppet:///modules/edbas/arping_w',
    mode	=>  '755',
    owner	=>  'root',
    group	=>  'root',
  }

  # Make sure that pcp.conf is set to 644
  file { '/etc/sysconfig/edb/pgpool3.6/pcp.conf':
    mode	=>  '644',
    owner	=>  'root',
    group	=>  'root',
  }

  # pgPool notify script
  file { '/usr/efm-2.1/bin/efm_pgpool_notify.sh':
    ensure	=>  present,
    content	=>  template('edbas/efm_pgpool_notify.sh.erb'),
    mode	=>  '755',
    owner	=>  'root',
    group	=>  'root',
  }

#  file { '/etc/pgpool-II-96/failover_stream.sh':
#    ensure	=>  present,
#    source	=>  'puppet:///modules/edbas/failover_stream.sh',
#    mode	=>  '755',
#    owner	=>  'root',
#    group	=>  'root',
#  }

#  file { '/etc/pgpool-II-96/follow_primary.sh':
#    ensure	=>  'present',
#    source	=>  'puppet:///modules/edbas/md5hash.sh',
#    mode	=>  '700',
#    owner	=>  'root',
#    group	=>  'root',
#  }
}
