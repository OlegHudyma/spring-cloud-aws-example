data "template_file" "email-notification-launch-script" {
  template = <<EOF
#!/bin/bash
export SPRING_PROFILES_ACTIVE=dev
sudo yum install git -y
sudo yum install java-1.8.0-openjdk -y
sudo yum install maven -y
git clone https://github.com/OlegHudyma/spring-cloud-aws-example.git
cd spring-cloud-aws-example/email-notification-service/
nohup mvn spring-boot:run &
EOF
}

resource "aws_iam_instance_profile" "email-notification-iam-profile" {
  name = "email-notification-instance-profile"
  role = aws_iam_role.email-notification-role.name
}

resource "aws_placement_group" "email-notification-placement-group" {
  name = "email-notification-placement-group"
  strategy = "spread"
}

resource "aws_launch_configuration" "email-notification-launch-configuration" {
  name_prefix = "email-notification-"
  image_id      = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  security_groups = [aws_security_group.email-notification-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.email-notification-iam-profile.id

  key_name = "test"
  user_data = base64encode(data.template_file.email-notification-launch-script.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "email-notification-autoscaling_group" {
  name = "email-notification-autoscaling_group"

  health_check_type = "ELB"
  health_check_grace_period = 300

  load_balancers = [aws_elb.email-notification-elb.id]

  max_size = 4
  min_size = 2
  desired_capacity = 3

  force_delete = true

  placement_group = aws_placement_group.email-notification-placement-group.id
  launch_configuration = aws_launch_configuration.email-notification-launch-configuration.name

  vpc_zone_identifier = [aws_subnet.email-notification-subnet.id]
}