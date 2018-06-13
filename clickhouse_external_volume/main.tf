terraform {
  required_version = ">= 0.8, <= 0.12"
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "ch_node_security_group" {
  name = "ch-node-security-group"
  description = "ClickHouse node security group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
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

# Possible volume types
# volume_type = 
#   gp2 for General Purpose SSD, 
#   io1 for Provisioned IOPS SSD, 
#   st1 for Throughput Optimized HDD, 
#   sc1 for Cold HDD, or 
#   standard for Magnetic

resource "aws_ebs_volume" "ch_ebs_volume_1" {
  availability_zone = "${var.availability_zone}"
  size = 120
  encrypted = false
  type = "gp2"
  tags {
    Name = "ch_ebs_volume_1"
  }
}


resource "aws_instance" "ch_node_1" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = [
    "${aws_security_group.ch_node_security_group.id}",
  ]
  key_name = "${var.key_name}"

  root_block_device {
    volume_size = "${var.root_block_device_volume_size}"
    volume_type = "gp2"
    delete_on_termination = true
  }

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
