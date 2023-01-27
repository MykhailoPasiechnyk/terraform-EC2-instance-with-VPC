#!/bin/bash

pip3 install ansible

sudo yum install git -y

cd /home/ec2-user
git clone https://github.com/MykhailoPasiechnyk/ansible-docker-cron-job.git

