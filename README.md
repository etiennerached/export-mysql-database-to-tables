export-mysql-database-to-tables
===============================

Export MySql and mariadb database to multiple files. Every table will be stored in a file

Tables will be stored in the current directory

Every table will have the extension .sql.gz

You can extract a file using the following command:

gunzip tablename.sql.gz

Usage
=====
bash <ThisFileName> <DatabaseHost> <DatabaseUsername> <DatabaseName>

Usage Example
=============
bash exportMysqlDatabaseToTables.sh localhost username dbName