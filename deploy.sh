#!/bin/bash

cluster_name=ivizone-splash
service_name=ivizone-splash-2

aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 853218352007.dkr.ecr.eu-west-1.amazonaws.com
docker build -t ivizone-splash .
docker tag ivizone-splash:latest 853218352007.dkr.ecr.eu-west-1.amazonaws.com/ivizone-splash:latest
docker push 853218352007.dkr.ecr.eu-west-1.amazonaws.com/ivizone-splash:latest
old_task=$(aws ecs list-tasks --cluster $cluster_name | jq -r '.taskArns[0]')
aws ecs update-service --cluster $cluster_name --service $service_name  --force-new-deployment
aws ecs stop-task --cluster $cluster_name --task $old_task
echo "Killing task $old_task"
