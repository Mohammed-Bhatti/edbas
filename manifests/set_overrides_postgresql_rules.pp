class edbas::set_overrides_postgresql_rules (
)
{
  $postgres_config_enteries = hiera_hash('postgresql::params', {})
  create_resources('postgresql::server::config_entry', $postgres_config_enteries)
}
