Create ECR
```sh
aws ecr create-repository --repository-name gitlab-ecs-app --region eu-central-1
```

Create ECS Cluster
```sh
aws ecs create-cluster --cluster-name gitlab-cluster --region eu-central-1
```

Create ECS Service
```sh
aws ecs create-service --cli-input-json file://ecs/fargate-service.json --region eu-central-1
```

Creating the task execution IAM role
```sh
aws iam create-role \
      --role-name ecsTaskExecutionRole \
      --assume-role-policy-document file://role.json

aws iam create-policy \
      --policy-name ecsTaskExecutionRolePolicy \
      --policy-document file://policy.json

aws iam attach-role-policy \
      --role-name ecsTaskExecutionRole \
      --policy-arn arn:aws:iam::632296647497:policy/ecsTaskExecutionRolePolicy
```

Clean Up
```sh
aws ecs delete-service --cluster demo-cluster --service demo-service --force
aws ecs delete-cluster --cluster demo-cluster 
```