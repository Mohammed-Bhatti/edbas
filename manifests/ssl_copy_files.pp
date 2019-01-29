class edbas::ssl_copy_files (
  String $pgdata, 
  $primary_node_ip	= hiera(edbas::edbasbaseline::primary_node_ip),
  $is_standby_node	= hiera(edbas::edbasbaseline::is_standby_node),
) 
{
  notify { "*******************STARTING SSL_COPY_FILES*******************" : }

  # testing repo sync
  # remove this comment
  # Copy cacerts.pem to $PGDATA
  file { "$pgdata/ca.crt":
    ensure	=> present,
    source	=> '/etc/pki/simp/x509/cacerts/cacerts.pem',
    mode	=> '0600',
    owner	=> 'enterprisedb', 
    group	=> 'enterprisedb', 
  }

  # Copy server.pem to $PGDATA
  file { "$pgdata/server.key":
    ensure	=> present,
    source	=> "/etc/pki/simp/x509/private/${facts['fqdn']}.pem",
    mode	=> '0400',
    owner	=> 'enterprisedb', 
    group	=> 'enterprisedb', 
  }

  # Copy server.crt to $PGDATA
  file { "$pgdata/server.crt":
    ensure	=> present,
    source	=> "/etc/pki/simp/x509/public/${facts['fqdn']}.pub",
    mode	=> '0400',
    owner	=> 'enterprisedb', 
    group	=> 'enterprisedb', 
  }

 # Copy the recovery.conf file.
 # We do this here because $PGDATA needs to be empty when we create the cluster.
 # And we don't copy to the primary node, only standby nodes
  if $is_standby_node {
    notify { "STANDBY NODE IS ON" : }
    file { "$pgdata/recovery.conf":
      ensure  => present,
      content => template('edbas/recovery.conf.erb'),
      mode    => '644',
      owner   => 'enterprisedb',
      group   => 'enterprisedb',
      replace => false,
     }
  }
}
