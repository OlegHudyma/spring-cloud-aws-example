resource "aws_subnet" "email-notification-subnet" {
  cidr_block = "10.53.2.0/24"
  vpc_id     = var.vpc_id

  map_public_ip_on_launch = true

  tags = {
    Name = "email-notification-subnet"
  }
}

resource "aws_security_group" "email-notification-security-group" {
  name   = "email-notification-allow-internal-8080"
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

resource "aws_security_group" "email-notification-elb-security-group" {
  name   = "email-notification-elb-allow-80"
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
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}