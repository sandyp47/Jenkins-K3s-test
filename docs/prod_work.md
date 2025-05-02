# new migration to hpts
https://jenkins-bluemix.kp.org/job/HP-BIO-KPMC/job/KPIF-ON/job/KPMCDMS/

# install for jenkins.kp.org/cdts-new

```bash
bash install.sh -i cdts-new -e prod.ads.clean
bash uninstall.sh -i cdts-new -e prod.ads.clean -n
```

# sync jenkins-ads jobs folders

transferring files:
```bash
assh csc2cxp00024828.cloud.kp.org
pbrun su - root
# add ~/.ssh/id_rsa key before doing rsync

cd /apps/kube/local-storage/pvc-4b65597a-5a83-45f4-99dc-b6eafe242f63_jenkins-ns-cdts-new_jenkins-pvc-cdts-new/jobs

# get everything for NWAPC_PanelSupportTool
rsync -avzcP csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/NWAPC_PanelSupportTool/" "./NWAPC_PanelSupportTool/"

# get config.xml skeletons and nothing else
rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/Video Visits Evolution/" "./Video Visits Evolution/"
rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/Pharmacy/" "./Pharmacy/"

# get everything for specific job folders
rsync -avzcP csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/Video Visits Evolution/jobs/GitHub-VVE-CI/jobs/vve-web-zoomapp" "./Video Visits Evolution/jobs/GitHub-VVE-CI/jobs/vve-web-zoomapp" 
rsync -avzcP csc2cxp21113181.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/Pharmacy/jobs/Pharmacy/jobs/GitHub-Pharmacy-CI/jobs/psb-covid19-service" "./Pharmacy/jobs/Pharmacy/jobs/GitHub-Pharmacy-CI/jobs/psb-covid19-service"

chown -R 1000:1000 .
```

# restart
https://jenkins.kp.org/cdts-new/restart

# test again
https://jenkins.kp.org/cdts-new/job/Video%20Visits%20Evolution/job/GitHub-VVE-CI/job/vve-web-zoomapp/



# stuff that is used by hpts but is proprietary
* CloudBees Folders Plus Plugin

# refresh hpts
```bash
cd /apps/kube/local-storage/pvc-66c7fd86-a316-450c-8c29-bf18784c96b2_jenkins-ns-hpts_jenkins-pvc-hpts/jobs/HP-BIO-KPMC
rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21114779.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/HP-BIO-KPMC/jobs/KPIF-ON/jobs/KPMCGSU/" "./jobs/KPIF-ON/jobs/KPMCGSU/"
chown -R 1000:1000 "./jobs/KPIF-ON/jobs/KPMCGSU/"

rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21114779.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/HP-BIO-KPMC/jobs/AutoSQLDeployment/" "./jobs/AutoSQLDeployment/"
chown -R 1000:1000 "./jobs/AutoSQLDeployment/"

rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21114779.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/HP-BIO-KPMC/jobs/KPIF-ON/jobs/KPMCDMS/" "./jobs/KPIF-ON/jobs/KPMCDMS/"
chown -R 1000:1000 "./jobs/KPIF-ON/jobs/KPMCDMS/"

rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21114779.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/HP-BIO-KPMC/jobs/KPMC-Utilities/" "./jobs/KPMC-Utilities/"
chown -R 1000:1000 "./jobs/KPMC-Utilities/"

```

https://jenkins-k3s.kp.org/hpts/restart

# connecting windows nodes
java -jar agent.jar -url https://jenkins-k3s.kp.org/hpts/ -webSocket -secret 198caa73380c574918c0e81771e33ecb2ce48f2f08e944a3583574ad96504c8f -name "csc2cwp21114506.cloud.kp.org" -workDir "e:\jenkins-agent"