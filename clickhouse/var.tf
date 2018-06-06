
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
