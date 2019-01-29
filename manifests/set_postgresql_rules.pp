class edbas::set_postgresql_rules (
  $params,
)
{
  create_resources('postgresql::server::config_entry', $params)
}
