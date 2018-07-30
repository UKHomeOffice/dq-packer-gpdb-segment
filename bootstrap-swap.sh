#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin
export INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
export HOSTNAME=$(hostname)

set -e
set -x

if ! $(df -T | grep -q /dev/mapper/secure); then
  aws --region eu-west-2 ssm put-parameter --name ${INSTANCE_ID} --value "$(uuidgen)" --overwrite --type "SecureString" --description ephemeral_encryption_sha_${HOSTNAME}
  aws --region eu-west-2 ssm get-parameter --name ${INSTANCE_ID} --with-decryption --query 'Parameter.Value' --output text | cryptsetup -y --cipher=aes-cbc-essiv:sha256 luksFormat /dev/nvme0n1
  aws --region eu-west-2 ssm get-parameter --name ${INSTANCE_ID} --with-decryption --query 'Parameter.Value' --output text  > /etc/ephemeral_crypto_key
  aws --region eu-west-2 ssm get-parameter --name ${INSTANCE_ID} --with-decryption --query 'Parameter.Value' --output text | cryptsetup luksAddKey /dev/nvme0n1 /etc/ephemeral_crypto_key
  aws --region eu-west-2 ssm get-parameter --name ${INSTANCE_ID} --with-decryption --query 'Parameter.Value' --output text | cryptsetup luksOpen /dev/nvme0n1 secure
  echo "secure UUID=$(cryptsetup luksDump /dev/nvme0n1 | grep "UUID" | awk -F' ' '{print $2}') /etc/ephemeral_crypto_key luks,nofail" >> /etc/crypttab
  mkfs.xfs /dev/mapper/secure
  mkdir -p /gpdb
  mount -o nodev,noatime,inode64,allocsize=16m /dev/mapper/secure /gpdb
  echo "/dev/mapper/secure /gpdb xfs nodev,noatime,inode64,allocsize=16m 0 0" >> /etc/fstab
  dd if=/dev/zero of=/dm-2 count=65536 bs=1MiB
  chmod 600 /dm-2
  mkswap /dm-2
  swapon -v /dm-2
  echo "/dm-2 swap swap defaults 0 0" >> /etc/fstab
  dhclient
else
  dhclient
fi
