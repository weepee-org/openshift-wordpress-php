# openshift-wordpress-php

Example project running:
- php webserver running wordpress

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project

```sh
> oc new-project example-wordpress-php \
    --description="Example WordPress PHP" \
    --display-name="Example WordPress HHVM"
```

build it all

```sh
> ./BuildAll.sh
```

#### Modifications for integrating in a private repository

create an ssh deploy key without passphrase
```sh
> ssh-keygen -f ~/.ssh/openshift-wordpress-php
```

```sh
> oc secrets new-sshauth openshift-wordpress-php --ssh-privatekey=/home/joeri/.ssh/openshift-wordpress-php
> oc secrets add serviceaccount/builder secrets/openshift-wordpress-php
```

Update the BuildConfig
(Modify and Append BuildConfig-Secrets.yaml.template to your Buildconfig)
(Remove old BuildConfig first !)

```sh
> oc delete -f Buildconfig.yaml
> oc create -f BuildConfig.yaml
```
Add your key to the deploy keys of you repository on GitHub

```sh
> cat ~/.ssh/openshift-wordpress-php.pub
```

#### Route-production.yml

Routes to a production hostname

```sh
> oc create -f Route-production.yaml
```

#### WebHooks

You can find the (github and generic) webhook in the openshift control pannel ! (Browse - Builds)
You can copy the url to clipboard and paste it in Github webhook url (handy for rolling updates)

#### Updating from branches

You can trigger on different Branches just modify your BuildConfig

```yaml
source:
  git:
    ref: release
    uri: https://github.com/weepee-org/openshift-example-project.git
  contextDir: php/
  type: Git
```
