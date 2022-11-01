#!/bin/bash

set -e

CURRENT_TASK=$(aws ecs describe-task-definition --task-definition "${TASK_FAMILY}" --region "${AWS_DEFAULT_REGION}")

NEW_TASK=$(echo $CURRENT_TASK | jq --arg IMAGE "${ECR_IMAGE}" '.taskDefinition | .containerDefinitions[0].image = $IMAGE | del(.taskDefinitionArn) | del(.revision) | del(.status) | del(.requiresAttributes) | del(.compatibilities) | del(.registeredAt) | del(.registeredBy)')

NEW_TASK_INFO=$(aws ecs register-task-definition --region "${AWS_DEFAULT_REGION}" --cli-input-json "$NEW_TASK")

if [ -n "$NEW_TASK_INFO" ]; then  
    NEW_REVISION=$(echo $NEW_TASK_INFO | jq '.taskDefinition.revision')
    UPDATE_SERVICE=$(aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --task-definition "${TASK_FAMILY}:$NEW_REVISION")
    echo $UPDATE_SERVICE
    echo "Deployment of complete"
else
    echo "exit: No task definition"
    exit;
fi



