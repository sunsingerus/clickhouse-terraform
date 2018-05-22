provider "aws" {
  region = "us-east-1"
#  region = "eu-west-1"
}

variable "vpc_id" {
  description = "Your VPC ID"
  default = "vpc-98172de1"
}

variable "subnet_id" {
  description = "Your Subnet ID"
  default = "subnet-52b6ef08"
}

variable "ami_id" {
  description = "Your AMI ID"
  default = "ami-43a15f3e"
}

variable "instance_type" {
  description = "Your instance type"
  default = "t2.micro"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "ssh_port" {
  description = "The SSH port"
  default = 22
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

resource "aws_instance" "my_server_1" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.my_security_group_1.id}"]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from server 1" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "my-server-1"
  }
}

resource "aws_instance" "my_server_2" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.my_security_group_1.id}"]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from server 2" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "my-server-2"
  }
}

resource "aws_instance" "my_server_3" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.my_security_group_1.id}"]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from server 3" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "my-server-3"
  }
}

#resource "aws_launch_configuration" "my_launch_configuration" {
#  image_id = "ami-43a15f3e"
#  instance_type = "t1.micro"
#  security_groups = ["${aws_security_group.my_security_group_1.id}"]
#
#  user_data = <<-EOF
#              #!/bin/bash
#              echo "Hello, World from launch configuration" > index.html
#              nohup busybox httpd -f -p "${var.server_port}" &
#              EOF
#
#  lifecycle {
#    create_before_destroy = true
#  }
#
#}
#
#resource "aws_autoscaling_group" "my_autoscaling_group" {
#  launch_configuration = "${aws_launch_configuration.my_launch_configuration.id}"
#  availability_zones = ["${data.aws_availability_zones.all.names}"]
#
#  min_size = 2
#  max_size = 10
#
#  load_balancers = ["${aws_elb.my_elb_1.name}"]
#  health_check_type = "ELB"
#
#  tags = {
#    Name = "my-autoscaling-group"
#  }
#}
#
#resource "aws_security_group" "my_elb_security_group_1" {
#  name = "my-elb-security-group-1"
#
#  egress {
#    from_port = 0
#    to_port = 0
#    protocol = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  ingress {
#    from_port = 80
#    to_port = 80
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_elb" "my_elb_1" {
#  name = "my-elb-1"
#  security_groups = ["${aws_security_group.my_elb_security_group_1.id}"]
#  availability_zones = ["${data.aws_availability_zones.all.names}"]
#
#  health_check {
#    healthy_threshold = 2
#    unhealthy_threshold = 2
#    timeout = 3
#    interval = 30
#    target = "HTTP:${var.server_port}/"
#  }
#
#  listener {
#    lb_port = 80
#    lb_protocol = "http"
#    instance_port = "${var.server_port}"
#    instance_protocol = "http"
#  }
#}
#
#data "aws_availability_zones" "all" {}
#
#output "ip_server_1" {
#  value = "${aws_instance.my_server_1.public_ip}"
#}
#
#output "ip_server_2" {
#  value = "${aws_instance.my_server_2.public_ip}"
#}
#
#output "ip_server_3" {
#  value = "${aws_instance.my_server_3.public_ip}"
#}
#
#output "elb_dns_name" {
#  value = "${aws_elb.my_elb_1.dns_name}"
#}
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
