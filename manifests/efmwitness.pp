class edbas::efmwitness (
  $license,
  $jresecuritypath,
  $pingserver,
) {

   # Install packages
   $pkgs = [ 'efm21-2.1.2-1.rhel7.x86_64',
            ]
    package { $pkgs:
      ensure  =>  'installed',
    }

  # simp::sudo does not have a way to handle #includedir, so add here
  sudo::default_entry { 'efm_requiretty':
    content     => [ '!requiretty', ],
    target      => ':efm',
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
    file { "$jresecuritypath/$files":
      ensure    => present,
      backup    => '.puppet-bak',
      source    => "puppet:///modules/edbas/$files",
      mode      => '644',
      owner     => 'root',
      group     => 'root',
    }
  }

  sudo::user_specification { 'efm_rule1':
    user_list   => ['efm'],
    runas       => 'enterprisedb',
    cmnd        => ['/usr/efm-2.1/bin/efm_db_functions'],
    passwd      => false,
  }

  sudo::user_specification { 'efm_rule2':
    user_list   => ['efm'],
    runas       => 'ALL',
    cmnd        => ['/usr/efm-2.1/bin/efm_root_functions',
                    '/usr/efm-2.1/bin/efm_address'],
    passwd      => false,
  }
}
