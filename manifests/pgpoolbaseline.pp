class edbas::pgpoolbaseline {

  $dirs = [ '/data/edb',
            '/data/edb/as9.6',
            '/data/edb/as9.6/backups',
            '/data/edb/as9.6/data',
            '/var/lib/edb/as9.6',
            '/var/lib/edb', ]

  group { 'enterprisedb':
    ensure	=> 'present',
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
    ensure  => directory,
    mode    => '0700',
    owner   => 'enterprisedb',
    group   => 'enterprisedb',
  }

  # pgpool setup
  pam::access::rule { 'pgpool':
    permission => '+',
    users => ['(pgpool)'],
    origins => ['ALL'],
    order => 1048
  }

  group { 'pgpool':
    ensure	=> 'present',
  } 
  ->
  user { 'pgpool':
    ensure => 'present',
    home   => '/home/pgpool',
    password => 'password',
    password_max_age => '9999',
    password_min_age => '0',
    shell  => '/bin/bash',
  }
}
