#!/usr/bin/env bash

old_database=$1;
new_database=$2;
if [[ $3 != '' ]];
then
  pass="-p$3";
else
  pass="";
fi
user='root';

function moveDatabase() {
  echo "Creating $new_database..."
  mysql -u $user $pass  -e "CREATE DATABASE \`$new_database\`;";
  for table in `mysql -u $user $pass -B -N -e "SHOW TABLES;" $old_database`;
  do
    echo "Moving $old_database.$table -> $new_database.$table"
    mysql -u $user -e "RENAME TABLE \`$old_database\`.\`$table\` to \`$new_database\`.\`$table\`";
  done
  echo "Dropping $old_database..."
  mysql -u $user $pass -e "DROP DATABASE \`$old_database\`;";
  echo "Move completed!"
}

echo "User: $user";
echo "Pass: $pass";
echo "Moving $old_database -> $new_database";
echo "Do you really want to rename this database?";
select yn in "Yes" "No"; do
  case $yn in
    Yes ) moveDatabase; break;;
    No ) exit;;
  esac
done