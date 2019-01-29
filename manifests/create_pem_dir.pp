class edbas::create_pem_dir (
  $datadir			= hiera(edbas::create_pem_server::datadir),
)
{
  file { $datadir :
    ensure	=> 'directory',
    owner	=> $user,
    group	=> $group,
    mode	=> '0700',
  }
}
