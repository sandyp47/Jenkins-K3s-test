#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )";

currentMultiBranchProject=
currentJobCount=0
while read line; do
  fixedLine=$(echo ${line} | sed -e 's/ | /|/g')
  folder=$(echo ${fixedLine} | awk -F\| '{print $1}')
  displayName=$(echo ${fixedLine} | awk -F\| '{print $2}')
  class=$(echo ${fixedLine} | awk -F\| '{print $3}')
  finalFolder=$(echo ${folder} | awk -F\/ '{print $NF}')
  if [[ "${folder}" =~ "${currentMultiBranchProject}" ]]; then
    if [ "${class}" = "class org.jenkinsci.plugins.workflow.job.WorkflowJob" ]; then
      let "currentJobCount++"
    fi
  elif [ ${currentJobCount} -gt 0 ]; then
    echo "${currentJobCount} ${currentMultiBranchProject}"
    currentJobCount=0
  fi

  if [ "${class}" == "class org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" ]; then
    currentMultiBranchProject=${folder}
    currentJobCount=0
  fi
done <bluemix_stale_branch_analysis.log