class edbas::create_encfs (
  $encfspasswd,
  $encfs,
  $encfs_mtpt,
){

  # Only run this on NDEV or SLAN
  if ($facts['edbasenv'] == 'slan') or ($facts['edbasenv'] == 'ndev') {
    notify { "Environment is ${edbasenv}" : }

    # Create the mountpoint for the encrypted FS
    file { $encfs_mtpt :
      ensure  => 'directory',
      mode    => '0700',
      owner   => 'enterprisedb',
      group   => 'enterprisedb',
    }
  
    file { '/var/lib/edb/as9.6/.encfspasswd':
      ensure  => present,
      content => template('edbas/encfspasswd.erb'),
      mode    => '400',
      owner   => 'enterprisedb',
      group   => 'enterprisedb',
      replace => false,
      require => File[$encfs_mtpt],
    }

    # Check that the encrypted FS is not mounted or exists
    exec { 'checkfs' :
      command	=> "/bin/mkdir ${encfs} ; chmod 755 ${encfs} ; chown enterprisedb:enterprisedb ${encfs}",
      unless	=> "runuser -l enterprisedb -c '/bin/test -d ${encfs}'",
    }

    # On all nodes, create/mount the encrypted FS for sigdbrd
    exec { 'encfs-setup':
      command	=> "runuser -l enterprisedb -c 'cat /var/lib/edb/as9.6/.encfspasswd | encfs -S ${encfs_mtpt} ${encfs} --standard'",
      onlyif	=> "/bin/test -d ${encfs}",
      require => Exec['checkfs'],
    }
  }
}
