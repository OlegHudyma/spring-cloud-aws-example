resource "aws_subnet" "profile-service-subnet" {
  cidr_block = "10.53.1.0/24"
  vpc_id     = var.vpc_id

  map_public_ip_on_launch = true

  tags = {
    Name = "profile-service-subnet"
  }
}

resource "aws_security_group" "profile-service-security-group" {
  name   = "profile-service-allow-internal-8080"
  vpc_id = var.vpc_id

  ingress {
    from_port = 8080
    protocol  = "tcp"
    to_port   = 8080
    cidr_blocks = [
    var.vpc_cidr]
  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

resource "aws_security_group" "profile-service-elb-security-group" {
  name   = "profile-service-elb-allow-80"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}