#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )";

while read line; do
  fixedLine=$(echo ${line} | sed -e 's/ | /|/g')
  folder=$(echo ${fixedLine} | awk -F\| '{print $1}')
  displayName=$(echo ${fixedLine} | awk -F\| '{print $2}')
  finalFolder=$(echo ${folder} | awk -F\/ '{print $NF}')
  if [ "${displayName}" != "${finalFolder}" ]; then
    echo "${finalFolder} = ${displayName}"
  fi
done <bluemix.folders.log