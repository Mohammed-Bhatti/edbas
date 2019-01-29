class edbas::set_logrotate (
   $audit_file,
){

  logrotate::rule { 'edb_audit_log':
    log_files           => [$audit_file],
    compress            => true,
    copytruncate        => true,
    create              => '0640 enterprisedb enterprisedb',
    dateext             => true,
    rotate_period       => 'daily',
    rotate              => 730,
  }

  exec { "semange $audit_file":
    path                => "/usr/bin:/usr/sbin:/bin:/sbin",
    command             => "semanage fcontext -a -t var_log_t ${audit_file}",
  } ~>
  exec { "restorecon $audit_file":
    path                => "/usr/bin:/usr/sbin:/bin:/sbin",
    command             => "restorecon -v ${audit_file}",
  }

  $directory = dirname($audit_file)
  notify {"Directory name = $directory ":}
  exec { "semange $directory":
    path                => "/usr/bin:/usr/sbin:/bin:/sbin",
    command             => "semanage fcontext -a -t var_log_t $directory",
  } ~>
  exec { "restorecon $directory":
    path                => "/usr/bin:/usr/sbin:/bin:/sbin",
    command             => "restorecon -v $directory",
  }
}

