#!/bin/bash

VBB_DATA_URL="https://www.vbb.de/media/download/2029"
VBB_DATA_FOLDER="/vbb_data"

download() {
  echo "Download data from $VBB_DATA_URL"
  echo "--------------------------------"

  mkdir "$VBB_DATA_FOLDER"
  curl -o /vbb_data.zip "$VBB_DATA_URL"
  py_command="from zipfile import ZipFile; zip_file=ZipFile('/vbb_data.zip'); zip_file.extractall('"$VBB_DATA_FOLDER"')"
  python -c "$py_command"
  rm /vbb_data.zip
}

prepare_db() {
  echo "Prepare DB"
  echo "----------"

  for sql_file in /vbb_schema/*.sql
  do
    sql_command="DROP TABLE IF EXISTS $( basename -s .sql "$sql_file" );"
    echo $sql_command
    crash -c "$sql_command"
    sql_command=$( <$sql_file )
    echo $sql_command
    crash -c "$sql_command"
  done
}

load() {
  echo "Load data into CrateDB"
  echo "----------------------"

  for csv_file in $VBB_DATA_FOLDER/*.txt
  do
    sql_command="COPY $( basename -s .txt "$csv_file" ) FROM '$csv_file' WITH (format='csv')"
    echo $sql_command
    crash -c "$sql_command"
  done
}

cleanup() {
  echo "Clean up"
  echo "--------"
  rm -r "$VBB_DATA_FOLDER"
}

download
prepare_db
load
cleanup
