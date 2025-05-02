# pre-requisite
- need to run `~/git/self-defense-cron/createK3sJenkinsWorkspaceDir.yml`
- need to update `inventory/k3s/prod_jenkins/group_vars/prod_jenkins.yml`
- need to update `inventory/k3s/prod_limitless/group_vars/prod_limitless.yml`
  - add team name to section:

```yaml
hosted_jenkins_k3s:
- team_name: "cdts"
- team_name: "cdts1"
- team_name: "hpts"
- team_name: "cdts-new"
```

# skipping
We're skipping custom ldap groups for now because they don't have Enterprise AD groups setup yet.

```bash
devsecops
bash
cd ~/git/jenkins_k3s/helm
bash uninstall.sh -i cdts1 -e prod.ads.clean -n

# optional if pvc still exits 
pvcId=$(kubectl get persistentvolume|grep cdts1|awk '{print $1}')
kubectl delete persistentvolume ${pvcId}
```

# create new instance for cdts1
```bash
devsecops
bash
cd ~/git/jenkins_k3s/helm
bash install.sh -i cdts1 -e prod.ads.clean -c prod.jenkins
a433154,y620425,s554715,i550526,s867341,l717789<enter>
# <enter><enter>
```

# export/import global creds from manual jenkins opensource
```bash
devsecops
bash
cd ~/git/jenkins_k3s/scripts/private
touch creds_cdts1
touch creds_cdts

cd ..
bash dumpGlobalCredsCdts.sh 
bash updateGlobalCredsCdts1.sh
```

# migrating jobs

## migrating folders

```bash
devsecops
bash
pvcId=$(kubectl get persistentvolume|grep cdts1|awk '{print $1}')
pvcPath=$(kubectl describe persistentvolume ${pvcId}|grep Path|awk '{print $2}')
echo ${pvcPath}

# ssh into the actual k3s node the instance is running on
assh csc2cxp00024835.cloud.kp.org
pbrun su - root
export pvcPath=/apps/kube/local-storage/pvc-c51c0573-b36c-418d-b2cb-b58035ebe165_jenkins-ns-cdts1_jenkins-pvc-cdts1

function syncAdsJobsFolder
{
  cd ${pvcPath}/jobs/

  folder=$1
  rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/${folder}/" "./${folder}/"
  chown -R 1000:1000 "./${folder}/"
}

# skipping CCCS
# skipping Video Visits Evolution
syncAdsJobsFolder Virtual_Care
syncAdsJobsFolder Member360
syncAdsJobsFolder "KP HealthHub"
syncAdsJobsFolder "CHAMAI SAL"
syncAdsJobsFolder CPM
syncAdsJobsFolder Devops
syncAdsJobsFolder GEMS
syncAdsJobsFolder AADUR
```

## migrating folder credentials
```bash
devsecops
bash
cd ~/git/jenkins_k3s/scripts
bash dumpAdsFolderCreds.sh   # updates local files with latest creds from jenkins-ads
                             #Note : need admin access to jenkins to run "bash dumpAdsFolderCreds.sh"
bash updateCdts1FolderCreds.sh  # updates cdts1 with folder creds from files
```

## restart cdts1
https://jenkins.kp.org/cdts1/restart