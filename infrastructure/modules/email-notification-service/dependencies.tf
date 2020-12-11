module "vpc" {
  source = "../network"
}

module "profile-service" {
  source = "../profile-service"
}