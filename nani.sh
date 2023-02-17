#!/bin/bash
cd /var/www/node_cicd/hello/

zip -r node-`date +%Y%m%d_%H%M%S`.zip /var/www/node_cicd/hello/* && mv *.zip /bkp/

git pull origin master

sudo npm install

#To execute this command you need to create service for nodejs application in remote server

#sudo systemctl restart node.service

#If your are using PM2. use below commands(un-comment)

#pm2 start cms.js
pm2 start cms.js --name"node"
#pm2 -f restart cms
