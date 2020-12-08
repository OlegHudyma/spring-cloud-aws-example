resource "aws_subnet" "profile-service-subnet" {
  cidr_block = "10.53.1.0/24"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "profile-service-subnet"
  }
}

resource "aws_security_group" "profile-service-security-group" {
  name = "profile-service-allow-http-8080"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}