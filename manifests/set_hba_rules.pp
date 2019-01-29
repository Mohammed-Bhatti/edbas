class edbas::set_hba_rules (
  $sys_accounts		= hiera(edbas::set_hba_rules::sys_accounts),
  $svc_accounts		= hiera(edbas::set_hba_rules::svc_accounts),
  $ssl_accounts		= hiera(edbas::set_hba_rules::ssl_accounts),
)
{
  # Check if we have a sys_accounts is a hash
  if !$sys_accounts.empty() {
    $sys_accounts.each |Array $sys_account| {
      slice($sys_account, 3) |$db, $sys_user, $ip| {
        #notify {"DB = ${db} USER = ${sys_user} IP = ${ip}": }
        postgresql::server::pg_hba_rule { "system account $db $sys_user $ip" :
          order             => 3,
          description       => "system account for $db $sys_user $ip",
          type              => 'hostssl',
          database          => $db,
          user              => $sys_user,
          address           => $ip,
          auth_method       => 'md5',
        }
      }
    }
  }

  # Check if svc_accounts is a hash
  if !$svc_accounts.empty() {
      $svc_accounts.each |Array $svc_account| {
      slice($svc_account, 3) |$svc_user, $type, $auth| {
        #notify {"USER = ${svc_user} AUTH = ${auth}": }
        postgresql::server::pg_hba_rule { "app service account $svc_user":
          order		=> 20,
          description	=> "app service account $svc_user",
          type		=> $type,
          database	=> 'all',
          user		=> $svc_user,
          address	=> '0.0.0.0/0',
          auth_method	=> 'ldap',
          auth_option	=> $auth
        }
      }
    }
  }

  # Check if ssl_accounts is a hash
  if !$ssl_accounts.empty() {
    $ssl_accounts.each |Array $ssl_account| {
      slice($ssl_account, 2) |$ssl_user, $auth| {
        #notify {"USER = ${ssl_user} AUTH = ${auth}": }
        postgresql::server::pg_hba_rule { "ssl account $ssl_user":
          order		=> 30,
          description	=> "ssl account $ssl_user",
          type		=> 'hostssl',
          database	=> 'all',
          user		=> $ssl_user,
          address		=> '0.0.0.0/0',
          auth_method	=> 'cert',
          auth_option	=> $auth
        }
      }
    }

    # set the pg_ident rule here
    $ssl_accounts.each |Array $ssl_account| {
      slice($ssl_account, 2) |$ssl_user, $auth| {
        #notify {"USER = ${ssl_user} AUTH = ${auth}": }
        postgresql::server::pg_ident_rule { "ssl ident account $ssl_user":
          order		=> 30,
          map_name	=> 'cert',
          system_username	=> $ssl_user,
          database_username	=> $ssl_user,
        }
      }
    }
  }
}
