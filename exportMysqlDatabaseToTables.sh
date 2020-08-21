#!/bin/bash

# mysqldump a specifc database.
# Every table will be stored in a file
# Usage Example: bash exportMysqlDatabaseToTables.sh localhost username dbName
# Author: Etienne Rached
# Notes:
#  * For security reasons the Password is not saved in the file nor passeed as an argument
#  * The user will be prompted to enter the password
#  * The files will be stored in the current directory
#    specified on command-line.

# If passed parameters are less than 3, display usage
errorMessage=$'Missing parameters: the command should be:\n'
usage=$"bash $(basename $0) DatabaseHost DatabaseUsername DatabaseName"
[ $# -lt 3 ] && echo "$errorMessage"$usage && exit 1

#$0 is for this filename
databaseHost=$1
databaseUser=$2
databasename=$3
backupDirectory=$(pwd)

echo -n "Enter the password for $databaseUser:"
read -s databasePassword
echo "Backing up tables of '$databasename' into directory=$backupDirectory"

countTables=0

for table in $(mysql -NBA -h $databaseHost -u $databaseUser -p$databasePassword -D $databasename -e 'show tables')
do
    echo "Backing up table: $databasename.$table"
    mysqldump -h $databaseHost -u $databaseUser -p$databasePassword $databasename $table | gzip > $backupDirectory/$databasename.$table.sql.gz
    countTables=$(( countTables + 1 ))
done

echo "$countTables tables dumped from database '$databasename' into directory=$backupDirectory"
