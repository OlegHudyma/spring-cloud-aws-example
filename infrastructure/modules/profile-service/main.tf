provider "aws" {
  region = "eu-central-1"
}

output "profiles_topic_arn" {
  value = aws_sns_topic.profiles-topic.arn
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}