#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "Installing base packages"
apt-get update
apt-get install -y gnupg software-properties-common vim curl wget make git unzip python3 python3-pip

echo "Installing terraform"
install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  > /etc/apt/sources.list.d/hashicorp.list
apt-get update
apt-get install -y terraform

echo "Configuring AWS credentials"
if [ ! -e "/vagrant/.vagrant-provision/aws/config" ] || [ ! -e "/vagrant/.vagrant-provision/aws/credentials" ]; then
  echo "Please create aws/config and aws/credentials files in .vagrant-provision." >&2
  exit 1
fi
mkdir -p /home/vagrant/.aws
cp /vagrant/.vagrant-provision/aws/* /home/vagrant/.aws/
chown -R vagrant:vagrant /home/vagrant/.aws

echo "Generate ssh key"
sudo -u vagrant ssh-keygen -o -a 100 -t ed25519 -f /home/vagrant/.ssh/id_ed25519 -C runner -N ""

echo "Installing AWS CLI v2"
ARCH="$(uname -m)"
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o /tmp/awscliv2.zip
unzip -q -o /tmp/awscliv2.zip -d /tmp
/tmp/aws/install --update

echo "Done"
