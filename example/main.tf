terraform {
  required_version = ">= 0.8, <= 0.12"
}


provider "aws" {
  region = "us-east-1"
#  region = "eu-west-1"
}

resource "aws_security_group" "my_security_group_1" {
  name = "security-group-1"
  description = "My Security Group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "3000"
    to_port = "3000"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#  ingress {
#    from_port = "${var.ssh_port}"
#    to_port = "${var.ssh_port}"
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "my_server_multiple" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.my_security_group_1.id}"]
  count = 3

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from server ${count.index}" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "my-server-${count.index}"
  }
}

#resource "aws_instance" "my_server_1" {
#  ami = "${var.ami_id}"
#  instance_type = "${var.instance_type}"
#  subnet_id = "${var.subnet_id}"
#  security_groups = ["${aws_security_group.my_security_group_1.id}"]
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World from server 1" > index.html
#              nohup busybox httpd -f -p "${var.server_port}" &
#              EOF
#
#  tags = {
#    Name = "my-server-1"
#  }
#}
#
#resource "aws_instance" "my_server_2" {
#  ami = "${var.ami_id}"
#  instance_type = "${var.instance_type}"
#  subnet_id = "${var.subnet_id}"
#  security_groups = ["${aws_security_group.my_security_group_1.id}"]
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World from server 2" > index.html
#              nohup busybox httpd -f -p "${var.server_port}" &
#              EOF
#
#  tags = {
#    Name = "my-server-2"
#  }
#}
#
#resource "aws_instance" "my_server_3" {
#  ami = "${var.ami_id}"
#  instance_type = "${var.instance_type}"
#  subnet_id = "${var.subnet_id}"
#  security_groups = ["${aws_security_group.my_security_group_1.id}"]
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World from server 3" > index.html
#              nohup busybox httpd -f -p "${var.server_port}" &
#              EOF
#
#  tags = {
#    Name = "my-server-3"
#  }
#}

resource "aws_launch_configuration" "my_launch_configuration_1" {
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.my_security_group_1.id}"]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from launch configuration" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
}

resource "aws_autoscaling_group" "my_autoscaling_group_1" {
  launch_configuration = "${aws_launch_configuration.my_launch_configuration_1.id}"
#  availability_zones = ["${data.aws_availability_zones.all.names}"]
  vpc_zone_identifier = ["${var.subnet_id}"]

  min_size = 2
  max_size = 10

  load_balancers = ["${aws_elb.my_elb_1.name}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "My ASG 1"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "my_elb_security_group_1" {
  name = "my-elb-security-group-1"
  description = "My ELB Security Group"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "my_elb_1" {
  name = "my-elb-1"
  security_groups = ["${aws_security_group.my_elb_security_group_1.id}"]
#  availability_zones = ["${data.aws_availability_zones.all.names}"]
  subnets = ["${var.subnet_id}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }
}

#data "aws_availability_zones" "all" {}
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
