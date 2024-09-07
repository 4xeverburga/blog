#!/bin/bash

# startup blog server

# dependencies
yum update
yum install -y gzip
yum install -y tar
yum install -y git

cd /home/ec2-user
# install node v20
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash | tee log.txt
. ~/.nvm/nvm.sh
nvm install v20

node install -g pm2

git clone https://github.com/4xeverburga/blog
cd blog

npm install
# still keeping dev
npm run dev 
