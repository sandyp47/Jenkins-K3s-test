# first level
```bash
cat ../../raw/ads.jobs.log |awk -F\/ '{print $1}'|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-ads-1.log
```

# two levels for largest
```bash
cat ../../raw/ads.jobs.log |awk -F\/ '{print $1"/"$2}'|grep HCA|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-ads-2.log
cat ../../raw/ads.jobs.log |awk -F\/ '{print $1"/"$2}'|grep MedicalInformatics|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-ads-2.log
cat ../../raw/ads.jobs.log |awk -F\/ '{print $1"/"$2}'|grep "Video Visits Evolution"|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh >> jenkins-ads-2.log
```

# three levels for largest
```bash
cat ../../raw/ads.jobs.log |awk -F\/ '{print $1"/"$2"/"$3}'|grep MedicalInformatics\/nQuiry|grep -v com.cloudbees.hudson.plugins.folder.Folder| sort|uniq -c|sort -rh > jenkins-ads-3.log
```

