# sync files from jenkins-bluemix

```bash
assh csc2cxp00024828.cloud.kp.org
pbrun su - root

function syncHPBIOKPMCFolder
{
  cd /apps/kube/local-storage/pvc-66c7fd86-a316-450c-8c29-bf18784c96b2_jenkins-ns-hpts_jenkins-pvc-hpts/jobs/HP-BIO-KPMC

  folder=$1
  rsync -avzcP --include "*/" --include="config.xml" --exclude="*" csc2cxp21114779.cloud.kp.org:"/var/lib/cloudbees-core-cm/jobs/HP-BIO-KPMC/${folder}" "./${folder}"
  chown -R 1000:1000 "./${folder}/"
}

syncHPBIOKPMCFolder jobs/KPIF-ON/jobs/KPMCCAM/
syncHPBIOKPMCFolder jobs/KPIF-ON/jobs/KPMCSS/
syncHPBIOKPMCFolder jobs/KPIF-ON/jobs/KPMCUserAuth/
syncHPBIOKPMCFolder jobs/KPIF-ON/jobs/SelfService/
syncHPBIOKPMCFolder jobs/KPIF-ON/jobs/utilities/
```

# restart jenkins-k3s.kp.org/hpts

https://jenkins-k3s.kp.org/hpts/restart

# update folder creds on devsecops
```bash
bash updateFolderCreds.sh
```