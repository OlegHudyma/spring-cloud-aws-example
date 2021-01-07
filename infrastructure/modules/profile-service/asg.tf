resource "aws_iam_instance_profile" "profile-service-iam-profile" {
  name = "profiles-service-iam-instance-profile"
  role = aws_iam_role.profile-service-role.name
}

resource "aws_placement_group" "profile-service-placement-group" {
  name     = "profile-service-placement-group"
  strategy = "spread"
}

resource "aws_launch_configuration" "profile-service-launch-configuration" {
  name_prefix   = "profile-service-"
  image_id      = "ami-03c3a7e4263fd998c"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  security_groups = [
  aws_security_group.profile-service-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.profile-service-iam-profile.id

  user_data = filebase64("scripts/launch_script.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "profile-service-autoscaling_group" {
  name = "profile-service-autoscaling_group"

  health_check_type         = "ELB"
  health_check_grace_period = 600

  load_balancers = [
  aws_elb.profile-service-elb.id]

  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  force_delete = true

  placement_group      = aws_placement_group.profile-service-placement-group.id
  launch_configuration = aws_launch_configuration.profile-service-launch-configuration.name

  vpc_zone_identifier = [
  aws_subnet.profile-service-subnet.id]
}