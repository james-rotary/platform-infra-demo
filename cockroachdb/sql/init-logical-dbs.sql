-- Idempotent logical database & role creation
-- Re-run safe: IF NOT EXISTS guards

CREATE DATABASE IF NOT EXISTS app_db;
CREATE DATABASE IF NOT EXISTS web_content_db;
-- Future: CREATE DATABASE IF NOT EXISTS auth_db;

-- Application roles (sample insecure passwords for dev; replace with secrets)
CREATE ROLE IF NOT EXISTS pim_app LOGIN;
CREATE ROLE IF NOT EXISTS web_content_app LOGIN;

GRANT CONNECT ON DATABASE app_db TO pim_app;
GRANT CONNECT ON DATABASE web_content_db TO web_content_app;

-- Optional: read-only projection roles (commented for now)
-- CREATE ROLE IF NOT EXISTS pim_readonly;
-- GRANT SELECT ON ALL TABLES IN DATABASE app_db TO pim_readonly;
-- ALTER DEFAULT PRIVILEGES FOR ROLE pim_app IN DATABASE app_db GRANT SELECT ON TABLES TO pim_readonly;
