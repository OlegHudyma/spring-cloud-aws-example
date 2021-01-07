# spring-cloud-aws-example
This repository contains example for "Spring Cloud AWS" training. 

# Requirements
In order to run this applications, you need:
- SQS Queue with name "profiles"
- DynamoDB Table with name "profiles"

# TODO
- Make ASG open for LB only
- Close email-notification-service LB, since it is not needed
- Generify Terraform modules
- Create different environment with Terragrunt using Terraform generic modules
- Apply best-practices (naming, modules, etc)
- Add ASG scalling policy
- Store Terraform state in S3 & Dynamodb