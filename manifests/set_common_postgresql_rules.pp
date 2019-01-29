class edbas::set_common_postgresql_rules (
  $params,
)
{
  create_resources('postgresql::server::config_entry', $params)
}
