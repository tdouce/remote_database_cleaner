## 1.0.0 - Nov. 10, 2014

1. Configure multiple "home"/"remote" applications
2. Remove RemoteDatabaseCleaner.reset. Instead use, RemoteDatabaseCleaner.remotes_config.reset
3. Adds option to configure remote_database_cleaner to use HTTPS
4. Refactors how remote_database_cleaner implements configuration
5. Removes trailing whitespaces
6. Adds tests for RemoteDatabaseCleaner::Config#has_home?
