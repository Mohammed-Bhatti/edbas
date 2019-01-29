class edbas::set_pg_fw_port 
(
  Integer $dbport,
  #$pgpool_ports,
  $efm_ports,
  $is_staging_node        = hiera(edbas::edbasbaseline::is_staging_node),
  #$pattern,
  #$svc,
) 
{
  $client_nets = hiera('simp_options::trusted_nets')

  notify { "opening port ${dbport}" : }
  iptables::listen::tcp_stateful { 'allow_postgres':
    trusted_nets => $client_nets,
    dports       => $dbport,
  }
 
  # NOTE: The following are hardcoded for testing ONLY!!!
  # Testing for PEM
  notify { "opening port 5445" : }
  iptables::listen::tcp_stateful { 'allow_postgres_5445':
    trusted_nets => $client_nets,
    dports       => 5445,
  }

  # Allow PEM access - unsecure
  notify { "opening PEM port 8080" : }
  iptables::listen::tcp_stateful { 'allow_PEM':
    trusted_nets => $client_nets,
    dports       => 8080,
  }

  # Allow PEM port - WS
  notify { "opening PEM port 8444" : }
  iptables::listen::tcp_stateful { 'allow_PEM_WS':
    trusted_nets => $client_nets,
    dports       => 8444,
  }

  # Allow PEM access - secure
  notify { "opening PEM port 8443" : }
  iptables::listen::tcp_stateful { 'allow_PEM_Secure':
    trusted_nets => $client_nets,
    dports       => 8443,
  }

  # EFM ports
  $efm_ports.each |Integer $efm_port| {
    notify { "opening pgpool port ${efm_port}" : }
    iptables::listen::tcp_stateful { "$efm_port":
      trusted_nets => $client_nets,
      dports       => $efm_port,
    }
  }
  
  # Open SNMP port
  #notify { "opening SNMP port 161" : }
  #iptables::listen::tcp_stateful { 'allow_SNMP':
  #  trusted_nets	=> $client_nets,
  #  dports		=> 161,
  #}

  # allow.hosts for Solarwinds access
  #if $pattern {
  #  tcpwrappers::allow { 'snmpd':
  #    pattern	=> $pattern,
  #    svc	=> $svc,
  #  }
  #}

  # pgPool ports
  #if !$is_staging_node {
  #  $pgpool_ports.each |Integer $port| {
  #    notify { "opening pgpool port ${port}" : }
  #    iptables::listen::tcp_stateful { "$port":
  #      trusted_nets => $client_nets,
  #      dports       => $port,
  #    }
  #  }
  
    # EFM ports
  #  $efm_ports.each |Integer $efm_port| {
  #    notify { "opening pgpool port ${efm_port}" : }
  #    iptables::listen::tcp_stateful { "$efm_port":
  #      trusted_nets => $client_nets,
  #      dports       => $efm_port,
  #    }
  #  }
  #}
}
