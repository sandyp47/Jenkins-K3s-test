# Jenkins K3S

Tools Modernization Project for Jenkins K3S

## Requirements

- TBD

## Respository Structure

- **helm/** Helm configuration files.
- **docs/** Project documentation.
- **scripts/** Support scripts for Jenkins migration

# dumping jobs

```bash
cd ~/git/jenkins_k3s
# make sure you have private/creds_bluemix proper <nuid>:<token>
source modules/functions.sh
listAllJenkinsJobs bluemix
# output is in raw/bluemix.jobs.log
```

# using yq

## install yq in your devsecops container

```bash
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64

sudo chmod +x /usr/local/bin/yq
```

# grab existing live jcasc config from live opensource instance

```bash
TOKEN=<nuid>:<token>
INSTANCE_NAME=<instance-name>

curl -u ${TOKEN} -X POST "https://jenkins.kp.org/${INSTANCE_NAME}/configuration-as-code/export" -o ${INSTANCE_NAME}-configuration.yaml
```

# grab existing live jcasc config from live cloudbees instance

```bash
TOKEN=<nuid>:<token>
INSTANCE_NAME=<instance-name>

curl -u ${TOKEN} -X POST "https://jenkins-${INSTANCE_NAME}.kp.org/configuration-as-code/export" -o ${INSTANCE_NAME}-configuration.yaml
```

# manipulating jasc config to extract a specific branch

This is grabbing the "tool" section from the live config, and then reformatting it so that it looks like the helm template we need for tools.

This includes adding the parent nodes of `controller:JCasC:configScripts:tools`, and then putting the `tool:` section into a multi-line field starting with `|`.

Replace the `tools.template` file in the `jenkins_k3s/helm/environments/<env_name>/jasc_templates/`

```bash
cat ${INSTANCE_NAME}-configuration.yaml |yq '.tool | {"tool": .} | {"tools": .} | {"configScripts": .} | {"JCasC": .}| {"controller": .}' | sed -e "s/tools:/tools: |/g" > tools.template
```

