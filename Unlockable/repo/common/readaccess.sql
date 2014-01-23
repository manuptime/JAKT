CREATE USER readaccess  WITH ENCRYPTED PASSWORD 'Unl0ck';
GRANT CONNECT ON DATABASE unlockable to readaccess;
\c unlockable
GRANT USAGE ON SCHEMA public to readaccess; /*thanks Dominic!*/
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readaccess;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readaccess;
