data "template_file" "profile-service-launch-script" {
  template = <<EOF
#!/bin/bash
export SPRING_PROFILES_ACTIVE=dev
sudo yum install git -y
sudo yum install java-1.8.0-openjdk -y
sudo yum install maven -y
git clone https://github.com/OlegHudyma/spring-cloud-aws-example.git
cd spring-cloud-aws-example/profile-service/
nohup mvn spring-boot:run &
EOF
}

resource "aws_iam_instance_profile" "profile-service-iam-profile" {
  name = "profiles-service-iam-instance-profile"
  role = aws_iam_role.profile-service-role.name
}

resource "aws_placement_group" "profile-service-placement-group" {
  name = "profile-service-placement-group"
  strategy = "spread"
}

resource "aws_launch_configuration" "profile-service-launch-configuration" {
  name_prefix = "profile-service-"
  image_id      = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  security_groups = [aws_security_group.profile-service-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.profile-service-iam-profile.id

  key_name = "test"
  user_data = base64encode(data.template_file.profile-service-launch-script.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "profile-service-autoscaling_group" {
  name = "profile-service-autoscaling_group"

  health_check_type = "ELB"
  health_check_grace_period = 300

  load_balancers = [aws_elb.profile-service-elb.id]

  max_size = 4
  min_size = 2
  desired_capacity = 3

  force_delete = true

  placement_group = aws_placement_group.profile-service-placement-group.id
  launch_configuration = aws_launch_configuration.profile-service-launch-configuration.name

  vpc_zone_identifier = [aws_subnet.profile-service-subnet.id]
}