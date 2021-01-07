resource "aws_iam_instance_profile" "email-notification-iam-profile" {
  name = "email-notification-instance-profile"
  role = aws_iam_role.email-notification-role.name
}

resource "aws_placement_group" "email-notification-placement-group" {
  name     = "email-notification-placement-group"
  strategy = "spread"
}

resource "aws_launch_configuration" "email-notification-launch-configuration" {
  name_prefix   = "email-notification-"
  image_id      = "ami-03c3a7e4263fd998c"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  security_groups = [
  aws_security_group.email-notification-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.email-notification-iam-profile.id

  user_data = filebase64("scripts/launch_script.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "email-notification-autoscaling_group" {
  name = "email-notification-autoscaling_group"

  health_check_type         = "ELB"
  health_check_grace_period = 300

  load_balancers = [
  aws_elb.email-notification-elb.id]

  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  force_delete = true

  placement_group      = aws_placement_group.email-notification-placement-group.id
  launch_configuration = aws_launch_configuration.email-notification-launch-configuration.name
  
  vpc_zone_identifier = [
  aws_subnet.email-notification-subnet.id]

  depends_on = [
  aws_sqs_queue.profile-email-notification-queue]
}