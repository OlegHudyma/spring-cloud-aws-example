data "template_file" "profile-service-launch-script" {
  template = <<EOF
Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0
--==BOUNDARY==
Content-Type: text/cloud-config; charset="us-ascii"
---
runcmd:
- export SPRING_PROFILES_ACTIVE=dev
- sudo yum install git -y
- sudo yum install java-1.8.0-openjdk -y
- sudo yum install maven -y
- git clone https://github.com/OlegHudyma/spring-cloud-aws-example.git
- cd spring-cloud-aws-example/profile-service/
- nohup mvn spring-boot:run &
- echo Completed!
--==BOUNDARY==--
EOF
}

resource "aws_iam_instance_profile" "profile-service-iam-profile" {
  name = "profiles-service-iam-instance-profile"
  role = aws_iam_role.profile-service-role.name
}

resource "aws_instance" "profile-service" {
  ami = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"

  tags = {
    Name = "profile-service"
  }

  associate_public_ip_address = true
  subnet_id = aws_subnet.profile-service-subnet.id
  vpc_security_group_ids = [
    aws_security_group.profile-service-security-group.id]

  iam_instance_profile = aws_iam_instance_profile.profile-service-iam-profile.name

  key_name = "test"
  user_data = base64encode(data.template_file.profile-service-launch-script.rendered)
}