class edbas::set_privs (
  $is_staging_node        = hiera(edbas::edbasbaseline::is_staging_node)
)
{

  sudo::default_entry { 'enterprisedb_requiretty':
    content	=> [ '!requiretty', ],
    target	=> ':enterprisedb',
  }

  sudo::user_specification { 'enterprisedb':
    user_list	=> ['enterprisedb'],
    runas	=> 'root',
    cmnd	=> ['/sbin/ip', '/sbin/arping'],
    passwd	=> false,
  }

  if !$is_staging_node {
    # simp::sudo does not have a way to handle #includedir, so add here
    sudo::default_entry { 'efm_requiretty':
      content	=> [ '!requiretty', ],
      target	=> ':efm',
    }

    sudo::user_specification { 'efm_rule1':
      user_list	=> ['efm'],
      runas	=> 'enterprisedb',
      cmnd	=> ['/usr/efm-2.1/bin/efm_db_functions'],
      passwd	=> false,
    }

    sudo::user_specification { 'efm_rule2':
      user_list	=> ['efm'],
      runas	=> 'ALL',
      cmnd	=> ['/usr/efm-2.1/bin/efm_root_functions',
                      '/usr/efm-2.1/bin/efm_address'],
      passwd	=> false,
    }
  }
}
