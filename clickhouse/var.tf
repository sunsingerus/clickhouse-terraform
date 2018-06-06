
variable "vpc_id" {
  description = "Your VPC ID"
  default = "vpc-98172de1"
}

variable "subnet_id" {
  description = "Your Subnet ID"
  default = "subnet-52b6ef08"
}

variable "ami_id" {
  description = "ClickHouse node AMI ID"
  default = "ami-fd433e82"
}

variable "instance_type" {
  description = "Your instance type"
  default = "t2.medium"
}

variable "ssh_port" {
  description = "The SSH port"
  default = 22
}

variable "ch_node_multiple_count" {
  description = "Number of nodes to be launched"
  default = 1
}

