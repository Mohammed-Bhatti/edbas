class edbas::edbasbaseline (
  $license,
  $db_user,
  $db_port,
  $database,
  $db_service_owner,
  $bin_dir,
  $recovery_conf_dir,
  $temp_dir,
  $user_email,
  $jre_security_path,
  $admin_port,
  $ping_server		= hiera(edbas::edbasbaseline::ping_server),
  $node1_ip		= hiera(edbas::edbasbaseline::node1_ip),
  $node2_ip		= hiera(edbas::edbasbaseline::node2_ip),
  $node3_ip		= hiera(edbas::edbasbaseline::node3_ip),
  $node1_port		= hiera(edbas::edbasbaseline::node1_port),
  $node2_port		= hiera(edbas::edbasbaseline::node2_port),
  $node3_port		= hiera(edbas::edbasbaseline::node3_port),
  $efm_vip		= hiera(edbas::edbasbaseline::efm_vip),
  $heartbeat_device0	= hiera('postgresql::pgpool::heartbeat_device0'),
  $dirs,
){

  group { 'enterprisedb':
    ensure  => 'present',
  }
  ->
  user { 'enterprisedb':
    ensure => 'present',
    home   => '/var/lib/edb/as9.6',
    password => '!!',
    password_max_age => '9999',
    password_min_age => '0',
    shell  => '/bin/bash',
  }
  ->
  pam::access::rule { 'enterprisedb':
    permission => '+',
    users => ['(enterprisedb)'],
    origins => ['ALL'],
    order => 1046
  }
  ->
  file { $dirs :
    ensure  => 'directory',
    mode    => '0700',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
  }
  
  file { '/var/lib/edb/as9.6/.bashrc':
    ensure  => present,
    content => template('edbas/bashrc.erb'),
    mode    => '644',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
    require => File[$dirs],
  }
 
  file { '/var/lib/edb/as9.6/setup.sh':
    ensure  => present,
    content => template('edbas/setup.sh.erb'),
    mode    => '700',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
    replace => false,
    require => File[$dirs],
  }

  file { '/var/lib/edb/as9.6/.bash_profile':
    ensure  => present,
    source  => 'puppet:///modules/edbas/bash_profile',
    mode    => '644',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
    replace => false,
    require => File[$dirs],
  }

  file { '/var/lib/edb/as9.6/.pgpass':
    ensure  => present,
    source  => 'puppet:///modules/edbas/pgpass',
    mode    => '600',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
    replace => false,
    require => File[$dirs],
  }

  file { '/var/lib/edb/as9.6/pg_roles.sql':
    ensure  => present,
    source  => 'puppet:///modules/edbas/pg_roles.sql',
    mode    => '600',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
    replace => false,
    require => File[$dirs],
  }

  # EFM setup
  pam::access::rule { 'efm':
    permission => '+',
    users => ['(efm)'],
    origins => ['ALL'],
    order => 1047
  }

  file { '/etc/efm-2.1/efm.properties':
    ensure  => present,
    content => template('edbas/efm.properties.erb'),
    mode    => '644',
    owner   => 'root',
    group   => 'root',
  }

  file { '/etc/efm-2.1/efm.nodes':
    ensure  => present,
    content => template('edbas/efm.nodes.erb'),
    mode    => '600',
    owner   => 'root',
    group   => 'root',
  }

  # copy JCE unlimited strength jurisdication policy files
  $files = ['local_policy.jar',
            'US_export_policy.jar']

  $files.each | String $files | {
    file { "$jre_security_path/$files":
      ensure	=> present,
      backup	=> '.puppet-bak',
      source	=> "puppet:///modules/edbas/$files",
      mode	=> '644',
      owner	=> 'root',
      group	=> 'root',
    }
  }
}

