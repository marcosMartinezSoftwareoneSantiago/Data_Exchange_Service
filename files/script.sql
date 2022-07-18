SELECT rolname AS "superUser"
  FROM pg_roles where rolsuper is true;
SELECT * FROM pg_roles;
SELECT current_role;
CREATE ROLE abc_open_data;
CREATE ROLE publishers WITH ROLE abc_open_data;
GRANT USAGE ON SCHEMA analytics TO publishers;
GRANT SELECT ON table analytics.downloads TO publishers;
SELECT * FROM information_schema.table_privileges
  WHERE grantee = 'publishers';
SET ROLE 'abc_open_data';
  SELECT * FROM analytics.downloads limit 10;
SET ROLE 'ccuser';
SELECT * FROM directory.datasets limit 10;
GRANT USAGE ON SCHEMA directory to publishers;
GRANT SELECT (id, create_date, hosting_path, publisher, src_size) ON directory.datasets to publishers;
SET ROLE 'abc_open_data';
  SELECT id, publisher, hosting_path--, datachecksum
   FROM directory.datasets;
SET ROLe 'ccuser';
CREATE POLICY enable_policy ON analytics.downloads
  FOR SELECT TO publishers USING (current_user = 'publisher');
ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;
SELECT * FROM directory.datasets limit 3;
SET ROLE 'abc_open_data';
 SELECT (id, create_date, hosting_path, publisher, src_size) FROM directory.datasets limit 3;
SET ROLe 'ccuser';