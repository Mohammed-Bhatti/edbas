class edbas::set_edbas_repo (
  $baseurl,
  $repo_name,
  $repo_descr
){

  yumrepo { $repo_name:
    descr	=> $repo_descr,
    name	=> $repo_name,
    baseurl	=> $baseurl,
    enabled	=> '1',
    gpgcheck	=> '0',
  }
}
