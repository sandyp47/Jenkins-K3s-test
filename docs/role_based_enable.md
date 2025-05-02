# implement authorizationStrategy for roleBased
- need to install plugin `Role-based Authorization Strategy`

- three global roles:
  - "admin"
    - always default to `- group: "DevOpsTools-Jenkins-Admins"`
    - add in group specified by customer as admin group
    - add in nuids specified by customer `- user: "k238491"`
  - "superuser"
    - add in group specified by customer as superuser group
  - "user"
    - always default to `- group: "DevOpsTools-Jenkins-Users"`

# sample authorizationStrategy section in casc
```
jenkins:
  authorizationStrategy:
    roleBased:
      roles:
        global:
        - entries:
          - group: "DevOpsTools-Jenkins-Admins"
          - group: "User-Defined-Admins"
          - user: "k238491"
          name: "admin"
          pattern: ".*"
          permissions:
          - "Overall/Administer"
        - name: "superuser"
        - entries:
          - group: "User-Defined-Superusers"
          pattern: ".*"
          permissions:
          - "Job/Move"
          - "Job/Build"
          - "Credentials/Delete"
          - "Credentials/ManageDomains"
          - "View/Create"
          - "Job/Read"
          - "Credentials/Update"
          - "Job/Delete"
          - "View/Configure"
          - "Metrics/HealthCheck"
          - "Metrics/ThreadDump"
          - "SCM/Tag"
          - "Job/Create"
          - "Job/Discover"
          - "Artifactory/Promote"
          - "Credentials/View"
          - "Run/Replay"
          - "Run/Delete"
          - "Job/Cancel"
          - "Artifactory/Release"
          - "Overall/Read"
          - "Run/Update"
          - "Credentials/Create"
          - "View/Delete"
          - "Job/Configure"
          - "Metrics/View"
          - "Job/Workspace"
          - "View/Read"
        - entries:
          - group: "DevOpsTools-Jenkins-Users"
          name: "user"
          pattern: ".*"
          permissions:
          - "Job/Build"
          - "SCM/Tag"
          - "View/Create"
          - "Job/Discover"
          - "Job/Read"
          - "Artifactory/Promote"
          - "Credentials/View"
          - "Run/Replay"
          - "Artifactory/Release"
          - "Job/Cancel"
          - "Overall/Read"
          - "Job/Workspace"
          - "View/Read"
          - "View/Configure"
```