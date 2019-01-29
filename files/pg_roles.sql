-- v1.0
/*
create database catapult;
create database ants;
create database my_spatial_db_2;
create database sigdb;
create database newqueue;
create database troposphere;
*/

\c my_spatial_db_2
create schema catapultspatial;

\c ants
create schema ants;

\c catapult
create schema datamaster;
create schema queue;
create schema search;

\c troposphere
create schema datamaster;
create schema queue;
create schema search;

\c newqueue
create schema queue;

\c postgres

create role catapult_ants;
create role catapult_read_only;

-- Table and view roles
create role rtv_catapult_public_all;
create role rtv_catapult_search_all;
create role rtv_catapult_search_ro;
create role rtv_catapult_datamaster_all;
create role rtv_catapult_public_ro;
create role rtv_troposphere_public_all;
create role rtv_troposphere_search_all;
create role rtv_troposphere_search_ro;
create role rtv_troposphere_datamaster_all;
create role rtv_troposphere_public_ro;
create role rtv_my_spatial_db_2_public_ro;
create role rtv_my_spatial_db_2_public_all;
create role rtv_my_spatial_db_2_catapultspatial_ro;
create role rtv_my_spatial_db_2_catapultspatial_all;
create role rtv_ants_ants_all;
create role rtv_newqueue_queue_all;
create role rtv_sigdb_public_all;

-- Sequence roles
create role rs_catapult_public_all;
create role rs_catapult_search_all;
create role rs_catapult_datamaster_all;
create role rs_troposphere_public_all;
create role rs_troposphere_search_all;
create role rs_troposphere_datamaster_all;
create role rs_ants_ants_all;
create role rs_newqueue_queue_all;
create role rs_my_spatial_db_2_public_all;
create role rs_my_spatial_db_2_catapultspatial_all;

-- Function roles
create role rf_catapult_public_all;
create role rf_catapult_datamaster_all;
create role rf_troposphere_public_all;
create role rf_troposphere_datamaster_all;
create role rf_newqueue_queue_all;
create role rf_my_spatial_db_2_public_all;
create role rf_my_spatial_db_2_catapultspatial_all;

-- Connect to database roles
create role role_connect_ants;
create role role_connect_catapult;
create role role_connect_troposphere;
create role role_connect_my_spatial_db_2;
create role role_connect_newqueue;
create role role_connect_sigdb;

grant connect on database ants to role_connect_ants;
grant connect on database ants to role_connect_catapult;
grant connect on database ants to role_connect_troposphere;
grant connect on database ants to role_connect_my_spatial_db_2;
grant connect on database ants to role_connect_newqueue;
grant connect on database sigdb to role_connect_sigdb;

-- Grant to roles
\c catapult
grant usage on schema public to rtv_catapult_public_all;
grant select,insert,update,delete on all tables in schema public to rtv_catapult_public_all;
grant  usage on all sequences in schema public to rs_catapult_public_all;
grant execute on all functions in schema public to rf_catapult_public_all;

\c troposphere
grant usage on schema public to rtv_troposphere_public_all;
grant select,insert,update,delete on all tables in schema public to rtv_troposphere_public_all;
grant  usage on all sequences in schema public to rs_troposphere_public_all;
grant execute on all functions in schema public to rf_troposphere_public_all;

\c ants
grant select,insert,update,delete on all tables in schema ants to rtv_ants_ants_all;
grant usage on all sequences in schema ants to rs_ants_ants_all;

\c catapult
grant select,insert,update,delete on all tables in schema search to rtv_catapult_search_all;
grant usage on all sequences in schema search to rs_catapult_search_all;

grant select on all tables in schema search to rtv_catapult_search_ro;

\c troposphere
grant select,insert,update,delete on all tables in schema search to rtv_troposphere_search_all;
grant usage on all sequences in schema search to rs_troposphere_search_all;

grant select on all tables in schema search to rtv_troposphere_search_ro;

\c my_spatial_db_2
grant select on all tables in schema public to rtv_my_spatial_db_2_public_ro;

grant select on all tables in schema catapultspatial to rtv_my_spatial_db_2_catapultspatial_ro;

grant select,insert,update,delete on all tables in schema catapultspatial to rtv_my_spatial_db_2_catapultspatial_all;
grant usage on all sequences in schema catapultspatial to rs_my_spatial_db_2_catapultspatial_all;
grant execute on all functions in schema catapultspatial to rf_my_spatial_db_2_catapultspatial_all;

\c catapult
grant select,insert,update,delete on all tables in schema datamaster to rtv_catapult_datamaster_all;
grant usage on all sequences in schema datamaster to rs_catapult_datamaster_all;
grant execute on all functions in schema datamaster to rf_catapult_datamaster_all;

grant select on picklist to rtv_catapult_public_ro;

\c troposphere
grant select,insert,update,delete on all tables in schema datamaster to rtv_troposphere_datamaster_all;
grant usage on all sequences in schema datamaster to rs_troposphere_datamaster_all;
grant execute on all functions in schema datamaster to rf_troposphere_datamaster_all;

grant select on picklist to rtv_troposphere_public_ro;

\c newqueue
grant select,insert,update,delete on all tables in schema queue to rtv_newqueue_queue_all;
grant usage on all sequences in schema queue to rs_newqueue_queue_all;
grant execute on all functions in schema queue to rf_newqueue_queue_all;

\c my_spatial_db_2
grant select,insert,update,delete on all tables in schema public to rtv_my_spatial_db_2_public_all;
grant usage on all sequences in schema public to rs_my_spatial_db_2_public_all;
grant execute on all functions in schema public to rf_my_spatial_db_2_public_all;

-- Create AD authenticated users
\c postgres
create role "svc_search-app" login;
create role "svc_search-rel-app" login;
create role "svc_ants-app" login;
create role "svc_cfg-app" login;
create role "svc_datamaster-app" login;
create role "svc_godzilla-app" login;
create role "svc_frameworks-app" login;
create role "svc_glidr-app" login;
create role "svc_ingest-app" login;
create role "svc_sigdb-app" login;

-- Grants to users
\c postgres

-- svc_search-app
\c catapult
grant usage on schema public to "svc_search-app";

\c troposphere
grant usage on schema public to "svc_search-app";

\c postgres
grant rtv_catapult_public_all to "svc_search-app";
grant rs_catapult_public_all to "svc_search-app";
grant rf_catapult_public_all to "svc_search-app";
grant rs_catapult_search_all to "svc_search-app";

grant rtv_troposphere_public_all to "svc_search-app";
grant rs_troposphere_public_all to "svc_search-app";
grant rf_troposphere_public_all to "svc_search-app";
grant rs_troposphere_search_all to "svc_search-app";

\c my_spatial_db_2
grant usage on schema catapultspatial to "svc_search-app";
\c postgres
grant rtv_my_spatial_db_2_catapultspatial_all to "svc_search-app";
grant rs_my_spatial_db_2_catapultspatial_all to "svc_search-app";
grant rf_my_spatial_db_2_catapultspatial_all to "svc_search-app";

\c catapult
grant usage on schema search to "svc_search-app";
grant rtv_catapult_search_all to "svc_search-app";

\c troposphere
grant usage on schema search to "svc_search-app";
grant rtv_troposphere_search_all to "svc_search-app";

-- svc_search-rel-app
\c catapult
grant usage on schema public to "svc_search-rel-app";

\c troposphere
grant usage on schema public to "svc_search-rel-app";

\c postgres
grant rtv_troposphere_public_all to "svc_search-rel-app";
grant rs_troposphere_public_all to "svc_search-rel-app";
grant rf_troposphere_public_all to "svc_search-rel-app";
grant rs_troposphere_search_all to "svc_search-rel-app";

\c catapult
grant usage on schema search to "svc_search-rel-app";
grant rtv_catapult_search_all to "svc_search-rel-app";

\c troposphere
grant usage on schema search to "svc_search-rel-app";
grant rtv_troposphere_search_all to "svc_search-rel-app";

\c my_spatial_db_2
grant usage on schema catapultspatial to "svc_search-rel-app";
\c postgres 
grant rtv_my_spatial_db_2_catapultspatial_all to "svc_search-rel-app";
grant rs_my_spatial_db_2_catapultspatial_all to "svc_search-rel-app";
grant rf_my_spatial_db_2_catapultspatial_all to "svc_search-rel-app";

\c my_spatial_db_2
grant usage on schema public to "svc_search-rel-app";
\c postgres
grant rtv_my_spatial_db_2_public_all to "svc_search-rel-app";
grant rs_my_spatial_db_2_public_all to "svc_search-rel-app";
grant rf_my_spatial_db_2_public_all to "svc_search-rel-app";

-- svc_ants-app
\c ants
grant usage on schema ants to "svc_ants-app";
grant rs_ants_ants_all to "svc_ants-app";
grant rtv_ants_ants_all to "svc_ants-app";

-- svc_cfg-app
\c catapult
grant usage on schema search to "svc_cfg-app";
grant usage on schema datamaster to "svc_cfg-app";

-- svc_cfg-app
\c troposphere
grant usage on schema search to "svc_cfg-app";
grant usage on schema datamaster to "svc_cfg-app";

\c postgres
grant usage on schema public to "svc_cfg-app";
grant rtv_catapult_public_all to "svc_cfg-app";
grant rs_catapult_public_all to "svc_cfg-app";
grant rf_catapult_public_all to "svc_cfg-app";

grant rtv_catapult_datamaster_all to "svc_cfg-app";
grant rs_catapult_datamaster_all to "svc_cfg-app";
grant rf_catapult_datamaster_all to "svc_cfg-app";

grant rtv_troposphere_public_all to "svc_cfg-app";
grant rs_troposphere_public_all to "svc_cfg-app";
grant rf_troposphere_public_all to "svc_cfg-app";

grant rtv_troposphere_datamaster_all to "svc_cfg-app";
grant rs_troposphere_datamaster_all to "svc_cfg-app";
grant rf_troposphere_datamaster_all to "svc_cfg-app";

grant rtv_troposphere_search_ro to "svc_cfg-app";

\c my_spatial_db_2
grant usage on schema public to "svc_cfg-app";
\c postgres
grant rtv_my_spatial_db_2_catapultspatial_ro to "svc_cfg-app";

\c my_spatial_db_2
grant usage on schema catapultspatial to "svc_cfg-app";
\c postgres
grant rtv_my_spatial_db_2_catapultspatial_ro to "svc_cfg-app";

-- svc_datamaster-app
\c catapult
grant usage on schema datamaster to "svc_datamaster-app";
\c postgres
grant rtv_catapult_datamaster_all to "svc_datamaster-app";
grant rs_catapult_datamaster_all to "svc_datamaster-app";
grant rf_catapult_datamaster_all to "svc_datamaster-app";

\c troposphere
grant usage on schema datamaster to "svc_datamaster-app";
\c postgres
grant rtv_troposphere_datamaster_all to "svc_datamaster-app";
grant rs_troposphere_datamaster_all to "svc_datamaster-app";
grant rf_troposphere_datamaster_all to "svc_datamaster-app";

\c catapult
grant usage on schema public to "svc_datamaster-app";
\c postgres
grant rtv_catapult_public_all to "svc_datamaster-app";
grant rs_catapult_public_all to "svc_datamaster-app";
grant rf_catapult_public_all to "svc_datamaster-app";

\c troposphere
grant usage on schema public to "svc_datamaster-app";
\c postgres
grant rtv_troposphere_public_all to "svc_datamaster-app";
grant rs_troposphere_public_all to "svc_datamaster-app";
grant rf_troposphere_public_all to "svc_datamaster-app";

-- svc_godzilla-app
\c catapult
grant usage on schema public to "svc_glidr-app";
\c postgres
grant rtv_catapult_public_ro to "svc_glidr-app";

\c troposphere
--grant usage on schema public to "svc_glidr-app";
grant usage on schema public to "svc_godzilla-app";
\c postgres
--grant rtv_troposphere_public_ro to "svc_glidr-app";
grant rtv_troposphere_public_ro to "svc_godzilla-app";

-- svc_frameworks-app
\c catapult
grant usage on schema public to "svc_frameworks-app";
grant usage on schema search to "svc_frameworks-app";

grant rtv_catapult_public_all to "svc_frameworks-app";
grant rs_catapult_public_all to "svc_frameworks-app";
grant rf_catapult_public_all to "svc_frameworks-app";

\c troposphere
grant usage on schema public to "svc_frameworks-app";
grant usage on schema search to "svc_frameworks-app";

grant rtv_troposphere_public_all to "svc_frameworks-app";
grant rs_troposphere_public_all to "svc_frameworks-app";
grant rf_troposphere_public_all to "svc_frameworks-app";

\c catapult
grant usage on schema public to "svc_frameworks-app";

\c postgres
grant rtv_catapult_search_all to "svc_frameworks-app";
grant rs_catapult_search_all to "svc_frameworks-app";

\c troposphere
grant usage on schema public to "svc_frameworks-app";
\c postgres
grant rtv_troposphere_search_all to "svc_frameworks-app";
grant rs_troposphere_search_all to "svc_frameworks-app";

\c newqueue
grant usage on schema queue to "svc_frameworks-app";
\c postgres
grant rtv_newqueue_queue_all to "svc_frameworks-app";
grant rf_newqueue_queue_all to "svc_frameworks-app";

\c catapult
grant usage on  schema datamaster to "svc_frameworks-app";

\c postgres
grant rtv_catapult_datamaster_all to "svc_frameworks-app";
grant rs_catapult_datamaster_all to "svc_frameworks-app";
grant rf_catapult_datamaster_all to "svc_frameworks-app";

\c troposphere
grant usage on  schema datamaster to "svc_frameworks-app";

\c postgres
grant rtv_troposphere_datamaster_all to "svc_frameworks-app";
grant rs_troposphere_datamaster_all to "svc_frameworks-app";
grant rf_troposphere_datamaster_all to "svc_frameworks-app";

\c my_spatial_db_2
grant usage on schema public to "svc_frameworks-app";
\c postgres
grant rtv_my_spatial_db_2_public_all to "svc_frameworks-app";
grant rs_my_spatial_db_2_public_all to "svc_frameworks-app";
grant rf_my_spatial_db_2_public_all to "svc_frameworks-app";

\c my_spatial_db_2
grant usage on schema catapultspatial to "svc_frameworks-app";
\c postgres
grant rtv_my_spatial_db_2_catapultspatial_all to "svc_frameworks-app";
grant rs_my_spatial_db_2_catapultspatial_all to "svc_frameworks-app";
grant rf_my_spatial_db_2_catapultspatial_all to "svc_frameworks-app";

-- svc_glidr-app
\c my_spatial_db_2
grant usage on schema public to "svc_glidr-app";
\c postgres
grant rtv_my_spatial_db_2_public_all to "svc_glidr-app";
grant rs_my_spatial_db_2_public_all to "svc_glidr-app";
grant rf_my_spatial_db_2_public_all to "svc_glidr-app";

\c my_spatial_db_2
grant usage on schema catapultspatial to "svc_glidr-app";
\c postgres
grant rtv_my_spatial_db_2_catapultspatial_all to "svc_glidr-app";
grant rs_my_spatial_db_2_catapultspatial_all to "svc_glidr-app";
grant rf_my_spatial_db_2_catapultspatial_all to "svc_glidr-app";

-- svc_ingest-app
grant usage on schema public to "svc_ingest-app";
\c postgres
grant rtv_catapult_public_all to "svc_ingest-app";
grant rs_catapult_public_all to "svc_ingest-app";
grant rf_catapult_public_all to "svc_ingest-app";

\c postgres
grant rtv_troposphere_public_all to "svc_ingest-app";
grant rs_troposphere_public_all to "svc_ingest-app";
grant rf_troposphere_public_all to "svc_ingest-app";

\c catapult
grant usage on schema datamaster to "svc_ingest-app";
\c postgres
grant rtv_catapult_datamaster_all to "svc_ingest-app";
grant rs_catapult_datamaster_all to "svc_ingest-app";
grant rf_catapult_datamaster_all to "svc_ingest-app";

\c troposphere
grant usage on schema datamaster to "svc_ingest-app";
\c postgres
grant rtv_troposphere_datamaster_all to "svc_ingest-app";
grant rs_troposphere_datamaster_all to "svc_ingest-app";
grant rf_troposphere_datamaster_all to "svc_ingest-app";

\c catapult
grant usage on schema public to "svc_ingest-app";
\c postgres
grant rtv_catapult_search_all to "svc_ingest-app";
grant rs_catapult_search_all to "svc_ingest-app";

\c troposphere
grant usage on schema public to "svc_ingest-app";
\c postgres
grant rtv_troposphere_search_all to "svc_ingest-app";
grant rs_troposphere_search_all to "svc_ingest-app";

\c sigdb
grant usage on schema public to rtv_sigdb_public_all;
grant select,insert,update,delete on all tables in schema public to rtv_sigdb_public_all;

\c sigdb
grant usage on schema public to "svc_sigdb-app";
\c postgres
grant rtv_sigdb_public_all to "svc_sigdb-app";

-- Grant connect to databases
grant role_connect_catapult to "svc_search-app";
grant role_connect_catapult to "svc_search-rel-app";
grant role_connect_troposphere to "svc_search-app";
grant role_connect_troposphere to "svc_search-rel-app";
grant role_connect_my_spatial_db_2 to "svc_search-app";
grant role_connect_my_spatial_db_2 to "svc_search-rel-app";
grant role_connect_catapult, role_connect_my_spatial_db_2 to "svc_cfg-app";
grant role_connect_troposphere, role_connect_my_spatial_db_2 to "svc_cfg-app";
grant role_connect_ants to "svc_ants-app";
grant role_connect_catapult to "svc_godzilla-app";
grant role_connect_catapult to "svc_frameworks-app";
grant role_connect_troposphere to "svc_godzilla-app";
grant role_connect_troposphere to "svc_frameworks-app";
grant role_connect_newqueue to "svc_frameworks-app";
grant role_connect_my_spatial_db_2 to "svc_frameworks-app";
grant role_connect_my_spatial_db_2 to "svc_glidr-app";
grant role_connect_catapult to "svc_ingest-app";
grant role_connect_troposphere to "svc_ingest-app";

-- Exceptions that need to be reduced
-- alter role "svc_frameworks-app" with superuser;
