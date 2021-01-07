resource "aws_elb" "profile-service-elb" {
  name = "profile-service-elb"
  security_groups = [
    aws_security_group.profile-service-elb-security-group.id
  ]
  subnets = [
    aws_subnet.profile-service-subnet.id,
  ]

  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:8080/actuator/health"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 8080
    instance_protocol = "http"
  }
}