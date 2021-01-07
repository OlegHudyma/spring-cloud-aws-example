dependency "vpc" {
  config_path = "../vpc"
}

dependency "profile-service" {
  config_path = "../profile-service"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_cidr = dependency.vpc.outputs.vpc_cidr
  profiles_topic_arn = dependency.profile-service.outputs.profiles_topic_arn
}