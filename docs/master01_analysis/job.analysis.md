```bash
devsecops
bash
cd ~/git/jenkins_k3s/scripts
source modules/functions.sh
listAllJenkinsJobs master01
```

# first level
```bash
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1}'|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-master01-1.log
```

# two levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2}'|grep CTO|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-master01-2.log
```

# three levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3}'|grep CTO\/Apigee-Hybrid|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-master01-3.log
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3}'|grep CTO\/CTO-IA|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-master01-3.log
```

# four levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4}'|grep CTO\/Apigee-Hybrid\/engineering|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-master01-4.log

cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4}'|grep CTO\/CTO-IA\/Apigee-Proxy-Automated-New|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-master01-4.log

```

# five levels for largest
```bash
cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4"/"$5}'|grep CTO\/Apigee-Hybrid\/engineering\/Ignite\ Apigee\ Hybrid\ Proxy\ Deploy|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-master01-5.log

cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4"/"$5}'|grep CTO\/Apigee-Hybrid\/engineering\/Deploy\ Apigee\ Hybrid\ Custom\ Proxy|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-master01-5.log

cat ~/git/jenkins_k3s/scripts/raw/master01.jobs.log |awk -F\/ '{print $1"/"$2"/"$3"/"$4"/"$5}'|grep CTO\/Apigee-Hybrid\/engineering\/Build\ Custom\ Apigee\ Hybrid\ Proxy|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-master01-5.log
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