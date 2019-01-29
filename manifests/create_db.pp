class edbas::create_db (
  $user		= hiera('postgresql::params::user'),
  $password	= hiera('postgresql::params::password')
  $dbname	= hiera('postgresql::params::dbname'),
) {

  $dbname.each |String $dbname| {
     postgresql::server::db { "$dbname":
       user	=> $user,
       password	=> postgresql_password($user, $password),
       require	=> Class['postgresql::server'],
     }
  }
}
