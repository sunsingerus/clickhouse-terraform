terraform {
  required_version = ">= 0.8, <= 0.12"
}


provider "aws" {
  region = "us-east-1"
#  region = "eu-west-1"
}

resource "aws_security_group" "ch_node_security_group" {
  name = "ch-node-security-group"
  description = "ClickHouse node security group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "8123"
    to_port = "8123"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "9000"
    to_port = "9000"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "9009"
    to_port = "9009"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "ch_node_multiple" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  security_groups = ["${aws_security_group.ch_node_security_group.id}"]
  key_name = "${var.key_name}"
  count = "${var.ch_node_multiple_count}"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "ch-node-${count.index}"
  }
}

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
