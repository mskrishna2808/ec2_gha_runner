#!/bin/bash

yum update -y
yum install docker -y
yum install git -y
yum install jq -y
systemctl enable docker
systemctl start docker

#======================================================================================
su - ec2-user -c "cd /home/ec2-user && \
aws secretsmanager get-secret-value --secret-id ec2_user_data --query SecretString --output text --region ap-south-1 >> .npmrc && \
mkdir actions-runner && cd actions-runner && \
curl -o actions-runner-linux-x64-2.308.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.308.0/actions-runner-linux-x64-2.308.0.tar.gz && \
tar xzf ./actions-runner-linux-x64-2.308.0.tar.gz && \
./config.sh --unattended --url https://github.com/mskrishna2808/ec2_gha_runner --token $(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $(aws secretsmanager get-secret-value --secret-id github_token --query SecretString --output text --region ap-south-1)" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/mskrishna2808/ec2_gha_runner/actions/runners/registration-token | jq .token | tr -d '"') && \
sudo ./svc.sh install && \
sudo ./svc.sh start"
#======================================================================================