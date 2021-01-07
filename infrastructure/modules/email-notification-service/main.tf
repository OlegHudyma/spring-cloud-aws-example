provider "aws" {
  region = "eu-central-1"
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "profiles_topic_arn" {
  type = string
}