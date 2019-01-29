class edbas::create_roles (
  $repuser_pwd,
  $efm_pwd,
  $connection_limit,
)
{

  # Create the repuser role as a default
  postgresql::server::role { 'repuser' :
    password_hash       => postgresql_password('repuser', $repuser_pwd),
    replication         => true,
    connection_limit    => $connection_limit,
  }

  # Create the efm user role
  postgresql::server::role { 'efm' :
    password_hash       => postgresql_password('efm', $efm_pwd),
    connection_limit    => $connection_limit,
  }

  # Create the efm_recovery_role role
  postgresql::server::role { 'efm_recovery_role' :
    login               => false,
  }

#  $roles = ['version()',
#            'pg_is_in_recovery()',
#            'pg_current_xlog_location()',
#            'pg_last_xlog_replay_location()',
#            'pg_xlog_replay_pause()',
#            'pg_is_xlog_replay_paused()',
#            'pg_xlog_replay_resume()']

  #$str = "version(), pg_is_in_recovery(), pg_current_xlog_location(), pg_last_xlog_replay_location(), pg_xlog_replay_pause(), pg_is_xlog_replay_paused(), pg_xlog_replay_resume()"


#  if !role_name.empty() {
#    $role_name.each| Array $role_name | {
#      slice($role_name, 2) | $role_name, $priv | {
#        postgresql::server::role {"db account $role_name" :
#          login                => false,
#          username     => $role_name,
#        }
#      }
#    }
#  }
#
#  if !$login_role_name.empty() {
#    $login_role_name.each|Array $login_role_name| {
#      slice($login_role_name, 3) |$login_role, $pwd, $priv | {
#        postgresql::server::role {"db account $login_role $pwd" :
#          password_hash => postgresql_password($login_role, $pwd),
#        }
#        if $priv {
#          postgresql::server::database_grant { "grant $login_role, $priv" :
#            privilege  => $priv,
#            role       => $login_role,
#            db         => 'edb',
#          }
#        }
#      }
#    }
#  }
}

