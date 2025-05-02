```bash
devsecops
bash
cd ~/git/jenkins_k3s/scripts
source modules/functions.sh
listAllJenkinsJobs bluemix
```

# first level
```bash
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1}'|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-bluemix-1.log
```

# two levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2}'|grep HP-BIO-KPMC|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-bluemix-2.log
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2}'|grep HP-BIO-EBSS|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-bluemix-2.log
```

# three levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2"/"$3}'|grep HP-BIO-KPMC\/KPIF-ON|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-bluemix-3.log
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2"/"$3}'|grep HP-BIO-EBSS\/ebss|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-bluemix-3.log
```

# four levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4}'|grep HP-BIO-KPMC\/KPIF-ON\/il-fw-splunk-logclient|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-bluemix-4.log

cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4}'|grep HP-BIO-KPMC\/KPIF-ON\/KPMCIntLayer|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-bluemix-4.log
```

# five levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4"/"$5}'|grep HP-BIO-KPMC\/KPIF-ON\/il-fw-splunk-logclient\/KPMCIntLayer|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-bluemix-5.log
```

# count workflow jobs per multibranch job
```bash
source ../../modules/functions.sh
listAllJenkinsJobs bluemix
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log | grep -e WorkflowMultiBranchProject | wc -l
  5304
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log | grep -e WorkflowJob | wc -l  
  39305
cat ~/git/jenkins_k3s/scripts/raw/bluemix.jobs.log | grep -e WorkflowMultiBranchProject -e WorkflowJob > bluemix_stale_branch_analysis.log
time bash analyzeBranches.sh | sort -hr > jobs_per_project.log
```