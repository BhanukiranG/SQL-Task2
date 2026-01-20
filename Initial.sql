RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/Session2.bak';

RESTORE DATABASE Session2DB
FROM DISK = '/var/opt/mssql/backup/Session2.bak'
WITH MOVE 'Session 2' TO '/var/opt/mssql/data/Session2.mdf',
MOVE 'Session 2_log' TO '/var/opt/mssql/data/Session2_log.ldf',
REPLACE;

SELECT name FROM sys.databases;

USE Session2DB;

SELECT * FROM sys.tables;

SELECT * FROM Employees;