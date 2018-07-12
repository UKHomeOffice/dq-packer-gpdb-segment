# dq-packer-gpdb-segment
This repository creates an AMI in AWS with Greenplum specific configuration

## Features

### `packer.json`
This file contains a wrap up for Ansible script to be run inside a Centos 7 machine

### `playbook.yml`
Ansible playbook installing packages, configuring OS settings

#### `bootstrap-raid.sh`
This file is used with a cron job and it creates a RAID0 file system and mounts it

#### `startcloudwatchlogs.sh`
Bash script that start Cloudwatch agent

## Deploying / Publishing
Drone min ver 0.5 is needed to deploy with `.drone.yaml` file

## Contributing

If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are warmly welcome.

More information in [`CONTRIBUTING`](./CONTRIBUTING)

## Licensing
The code in this project is licensed under this [`LICENSE`](./LICENSE)
