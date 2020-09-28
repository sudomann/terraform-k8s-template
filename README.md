<!-- @format -->

# Terraform Deployment Sample

This repo is set up such that resources for other cloud providers can be added as a new folder (module) at the same level as `gcp/`.

## Getting Started

_Take note:_ This repo assumes remote state is to be configured with a
Terraform Enterprise account (free tier with limited capability) on app.terraform.io.

[Setup your workstation credentials.](https://www.terraform.io/docs/commands/cli-config.html)
Sign into [app.terraform.io](https://app.terraform.io) and obtain a new token if you need to.

## Authentication

### GCP
Authenticate using a credential file for a service account with the following GCP IAM roles:

```txt
Cloud Build Editor
Compute Instance Admin (v1)
Compute Network Admin
Compute Network User
Compute Security Admin
Kubernetes Engine Cluster Admin
DNS Administrator
Service Account User
Storage Admin
```

### AWS

_None_

### Azure

_None_



## Notes and TODO's

### GCP

#### IAM

- TODO: Preferably create custom role with just the very particular permissions that terraform needs to operate.

#### Cloud Build

- When using the Cloud Build trigger modules, you need to ensure the hosted repository (Github, Bitbucket, etc.) has been already set up to be mirrored: <https://source.cloud.google.com/>.

#### Cloud Storage

- When naming a bucket in the format of a website, e.g. `usercontent.myproduct.com`, the email of the service account being used to create the resource must be added as an owner of the site. See [reference](https://stackoverflow.com/questions/19060226/cant-create-a-bucket-with-my-domain-name).



### AWS

_None_

### Azure

_None_
